####################################################################
#
#     This file was generated using XDR::Parse version v0.3.1
#                   and LibVirt version v10.3.0
#
#      Don't edit this file, use the source template instead
#
#                 ANY CHANGES HERE WILL BE LOST !
#
####################################################################


use v5.20;
use warnings;
use experimental 'signatures';
use Future::AsyncAwait;

package Sys::Async::Virt::Connection v0.0.6;

use parent qw(IO::Async::Notifier);

use Carp qw(croak);
use Log::Any qw($log);

sub close($self) {
    die $log->fatal(
        "The 'close' method must be implemented by concrete sub-classes");
}

async sub connect($self) {
    die $log->fatal(
        "The 'connect' method must be implemented by concrete sub-classes");
}

sub is_secure($self) {
    return 0;
}

async sub read($self, $type, $len) {
    die $log->fatal( "Unsupported transfer type $type" ) unless $type eq 'data';
    await $self->{in}->read_exactly( $len );
}

async sub write($self, @data) {
    while (@data) {
        my $data = shift @data;
        next unless length($data) > 0;
        await $self->{out}->write($data);
    }
    return;
}


1;

__END__

=head1 NAME

Sys::Async::Virt::Connection - Connection to LibVirt server (abstract
 base class)

=head1 VERSION

v0.0.6

=head1 SYNOPSIS

  use v5.20;
  use Future::AsyncAwait;
  use Sys::Async::Virt::Connection::Factory;

  my $factory = Sys::Async::Virt::Connection::Factory->new;
  my $conn    = $factory->create_connection( 'qemu:///system' );

=head1 DESCRIPTION

This module presents an abstract base class.

=head1 METHODS

=head2 connect

  await $conn->connect;

Establishes a connection with the server indicated by the URL passed
to the C<new> method.

Note that implementing classes must provide a C<new> method.

=head2 is_secure

  my $bool = $self->is_secure;

Returns C<true> when the transport is considered secure. This default version
returns C<false>, failing on the safe side.

=head2 read

  my $data = await $conn->read( 'data', 42 );
  my $fds  = await $conn->read( 'fds',   2 );

Reads bytes or file descriptors from the connection, returning a string (when
requested to read data) or a reference to an array of file descriptors (when
requested to read file descriptors).

=head2 write

  await $conn->write( 'data1', 'data2', ... );
  await $conn->write( [ $fd1, $fd2, ... ] );

Writes data (passed as strings) and file descriptors (passed as arrays of
descriptors) to the connection.

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT


  Copyright (C) 2024 Erik Huelsmann

All rights reserved. This program is free software;
you can redistribute it and/or modify it under the same terms as Perl itself.
