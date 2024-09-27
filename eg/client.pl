#!/usr/bin/perl

use v5.20;
use warnings;
use experimental 'signatures';
use Future::AsyncAwait;
use Feature::Compat::Try;

use IO::Async::Loop;
use IO::Async::Stream;
use Log::Any qw($log);
use Log::Any::Adapter;
use Log::Any::Adapter::Stdout;
use Protocol::Sys::Virt::Transport;
use Protocol::Sys::Virt::Remote;
use Sys::Async::Virt;
use Sys::Async::Virt::Connection::Factory;

Log::Any::Adapter->set('Stdout', log_level => 'trace');
my $loop = IO::Async::Loop->new;
my $prot = 'Protocol::Sys::Virt::Remote::XDR';

my $factory = Sys::Async::Virt::Connection::Factory->new;
my $conn = $factory->create_connection( 'qemu:///system' );
$loop->add( $conn );

await $conn->connect;
$log->trace( 'Created libvirt connection socket' );

async sub data_pump($stream, $transport) {
    my $eof;
    my $data;
    while (not $eof) {
        my ($len, $type) = $transport->need;
        $log->trace( "Reading data from stream: initiated (len: $len)" );
        ($data, $eof) = await $conn->read( $type, $len );
        $log->trace( 'Reading data from stream: completed' );

        await Future->wait_all( $transport->receive($data) );
        $log->trace( 'Processed input data from stream' );
    }
}

my $transport = Protocol::Sys::Virt::Transport->new(
    role => 'client',
    on_send => async sub($opaque, @data) {
        $log->trace( "on_send called with opaque value $opaque" );
        $log->trace( 'on_send called with ' . scalar(@data) . ' arguments');
        await $conn->write( $opaque, @data );

        $log->trace( 'Finished sending data' );
        return $opaque;
    });
$log->trace( 'Created libvirt transport' );

my $remote = Protocol::Sys::Virt::Remote->new(
    role => 'client',
    );
$remote->register($transport);
$log->trace( 'Created remote message processor' );

my $virt = Sys::Async::Virt->new(
    remote => $remote,
    );
$loop->add( $virt );
$log->trace( 'Created libvirt client application layer' );

data_pump( $conn, $transport )->retain;
$log->trace( 'Started data pump' );


await $virt->auth( $prot->AUTH_NONE );
$log->trace( 'Authenticated' );

await $virt->open( 'qemu:///system' );

use Data::Dumper;
try {
    my $es = await $virt->domain_event_register_any(
        $virt->DOMAIN_EVENT_ID_LIFECYCLE);
    my $rv = await $virt->node_get_cpu_stats($virt->CPU_STATS_ALL_CPUS);
    say Dumper($rv);
    #$log->trace( 'Listed' );
    $rv = await $virt->list_all_domains;
    say scalar $rv->@*;

    my $p = await $rv->[0]->get_scheduler_parameters;
    say Dumper($p);

    while ( ( my $event ) = await $es->next_event ) {
        say 'event: ' . Dumper($event);
    }
}
catch ($e) {
    say 'abc: ' . Dumper($e);
}

await $virt->close;
