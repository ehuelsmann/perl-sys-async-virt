#!/usr/bin/perl

use v5.20;
use warnings;
use experimental 'signatures';
use Future;
use Future::AsyncAwait;
use Feature::Compat::Try;

use Log::Any qw($log);
use Log::Any::Adapter;
use Log::Any::Adapter::Stdout;

use Sys::Async::Virt;

Log::Any::Adapter->set('Stdout', log_level => 'trace');
my $virt = Sys::Async::Virt->new(
    url => 'qemu:///system',
    );
$log->trace( 'Created libvirt client application layer' );


async sub main() {
    await $virt->connect;
    try {
        my $cells_free_mem = await $virt->get_cells_free_memory( 0, 99 );
        say '';
        say '';

        my $i = 0;
        for my $free (@$cells_free_mem) {
            say "Free memory in host NUMA cell $i: $free bytes";
            $i++;
        }
        say '';
        say '';
    }
    catch ($e) {
        say "Error: $e";
        exit 1;
    }
    $virt->stop;
}

await Future->needs_all(
    $virt->run,
    main()
    );
