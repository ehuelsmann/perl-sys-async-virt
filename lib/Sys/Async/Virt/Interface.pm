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


use v5.14;
use warnings;
use Future::AsyncAwait;

package Sys::Async::Virt::Interface v10.3.0;

use Carp qw(croak);
use Log::Any qw($log);

use Protocol::Sys::Virt::Remote::XDR v10.3.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

use constant {
    XML_INACTIVE => 1 << 0,
};


sub new {
    my ($class, %args) = @_;
    return bless {
        id => $args{id},
        client => $args{client},
    }, $class;
}

sub create {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_INTERFACE_CREATE,
        { iface => $self->{id}, flags => $flags // 0 } );
}

sub destroy {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_INTERFACE_DESTROY,
        { iface => $self->{id}, flags => $flags // 0 } );
}

sub get_xml_desc {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_INTERFACE_GET_XML_DESC,
        { iface => $self->{id}, flags => $flags // 0 } );
}

sub is_active {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_INTERFACE_IS_ACTIVE,
        { iface => $self->{id},  } );
}

sub undefine {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_INTERFACE_UNDEFINE,
        { iface => $self->{id},  } );
}



1;


__END__

=head1 NAME

Sys::Async::Virt::Interface - Client side proxy to remote LibVirt (network) interface

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EVENTS

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS

=head2 create

  await $iface->create( $flags = 0 );
  # -> (* no data *)

=head2 destroy

  await $iface->destroy( $flags = 0 );
  # -> (* no data *)

=head2 get_xml_desc

  $xml = await $iface->get_xml_desc( $flags = 0 );

=head2 is_active

  $active = await $iface->is_active;

=head2 undefine

  await $iface->undefine;
  # -> (* no data *)


=head1 CONSTANTS

=over 8

XML_INACTIVE

=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

