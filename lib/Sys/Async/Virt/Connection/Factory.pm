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

package Sys::Async::Virt::Connection::Factory v0.0.6;

use Carp qw(croak);
use Log::Any qw($log);
use Protocol::Sys::Virt::URI; # imports 'parse_url'

sub new {
    my ($class, %args) = @_;
    return bless {
        drivers => [
            { transport => '', class => 'Local', host => 0 },
            { transport => 'unix', class => 'Local', host => 0 },
            # { transport => '', class => 'TCP', host => 1 },
            # { transport => 'tls', class => 'TCP' },
            # { transport => 'tcp', class => 'TCP' },
            # { transport => 'ext', class => 'Process' },
            # { transport => 'ssh', class => 'SSH' },
            ],
    }, $class;
}

# Not documented in the POD: not a method
sub _cls_name($n) {
    return ($n =~ s/^\+//)
        ? $n : "Sys::Async::Virt::Connection::$n";
}

sub create_connection( $self, $url, %args ) {
    my %components = parse_url( $url );
    my $transport = $components{transport} // '';
    my $host = $components{host} // '';

    for my $driver (@{ $self->{drivers} }) {
        if ($transport eq $driver->{transport}) {
            if (defined $driver->{host}) {
                if (($driver->{host} and $host)
                    or (not $driver->{host} and not $host)) {
                    my $c = _cls_name( $driver->{class} );
                    if (not eval "require $c; 1") {
                        die @!;
                    }
                    return $c->new( $url, %args );
                }
            }
            else { # "host" not defined, so not required
                my $c = _cls_name( $driver->{class} );
                eval "require $c";
                return $c->new( $url, %args );
            }
        }
    }

    $log->trace( "URL not matched: $url" );
    return;
}

1;

__END__

=head1 NAME

Sys::Async::Virt::Connection::Factory - Class for
 instantiation of connection objects

=head1 VERSION

v0.0.6

=head1 SYNOPSIS

  use v5.20;
  use Future::AsyncAwait;

  use Sys::Async::Virt::Connection::Factory;

  my $factory = Sys::Async::Virt::Connection::Factory->new(
     drivers => [
            { transport => '', class => 'Local', host => 0 },
            { transport => 'unix', class => 'Local', host => 0 },
     ]
  );
  my $conn = $factory->create_connection( 'qemu+unix:///system' );

=head1 DESCRIPTION

This module provides a central entrypoint to instantiate connections to
LibVirt servers for configured means of transport.

=head1 CONSTRUCTOR

=head2 new

Accepts the following named parameters:

=over 8

=item * drivers

An array mapping URLs to driver classes. Each array entry is a hash with
the following keys:

=over 8

=item * transport

An empty string if no transport is specified; the part after the '+'
in the URL protocol (i.e. C<ssh> in C<qemu+ssh://>).

=item * host

A boolean indicating if a host value is allowed (C<undef>),
prohibited (0) or required (1).

=item * class

The (shortened) name of the driver class: Values I<not> starting with a
C<+>, will have C<Sys::Async::Virt::Connection::> prepended; those which
I<are> starting with a C<+> will have it removed.

E.g. C<Local> will resolve to C<Sys::Async::Virt::Connection::Local> and
C<+YourPackage::Local> resolves to C<YourPackage::Local>.

=back

The default value maps the following transports: C<''>, C<unix>.

=back

=head1 METHODS

=head2 create_connection

  my $conn = $factory->create_connection( $url );

Instantiates the connection driver configured to service the given C<$url>.

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT


  Copyright (C) 2024 Erik Huelsmann

All rights reserved. This program is free software;
you can redistribute it and/or modify it under the same terms as Perl itself.
