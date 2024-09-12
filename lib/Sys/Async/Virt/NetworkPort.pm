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

package Sys::Async::Virt::NetworkPort v10.3.0;

use Carp qw(croak);
use Log::Any qw($log);

use Protocol::Sys::Virt::Remote::XDR v10.3.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

use constant {
    BANDWIDTH_IN_AVERAGE  => "inbound.average",
    BANDWIDTH_IN_PEAK     => "inbound.peak",
    BANDWIDTH_IN_BURST    => "inbound.burst",
    BANDWIDTH_IN_FLOOR    => "inbound.floor",
    BANDWIDTH_OUT_AVERAGE => "outbound.average",
    BANDWIDTH_OUT_PEAK    => "outbound.peak",
    BANDWIDTH_OUT_BURST   => "outbound.burst",
};


sub new {
    my ($class, %args) = @_;
    return bless {
        id => $args{id},
        client => $args{client},
    }, $class;
}

sub delete($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_NETWORK_PORT_DELETE,
        { port => $self->{id}, flags => $flags // 0 } );
}

sub get_xml_desc($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_NETWORK_PORT_GET_XML_DESC,
        { port => $self->{id}, flags => $flags // 0 } );
}

sub set_parameters($self, $params, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_NETWORK_PORT_SET_PARAMETERS,
        { port => $self->{id}, params => $params, flags => $flags // 0 } );
}



1;


__END__

=head1 NAME

Sys::Async::Virt::NetworkPort - Client side proxy to remote LibVirt network port

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EVENTS

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS

=head2 delete

  await $port->delete( $flags = 0 );
  # -> (* no data *)

=head2 get_xml_desc

  $xml = await $port->get_xml_desc( $flags = 0 );

=head2 set_parameters

  await $port->set_parameters( $params, $flags = 0 );
  # -> (* no data *)


=head1 CONSTANTS

=over 8

BANDWIDTH_IN_AVERAGE

=item BANDWIDTH_IN_PEAK

=item BANDWIDTH_IN_BURST

=item BANDWIDTH_IN_FLOOR

=item BANDWIDTH_OUT_AVERAGE

=item BANDWIDTH_OUT_PEAK

=item BANDWIDTH_OUT_BURST

=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

