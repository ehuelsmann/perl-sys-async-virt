####################################################################
#
#     This file was generated using XDR::Parse version ,
#        XDR::Gen version __XDR_GEN_VERSION__ and LibVirt version v10.3.0
#
#      Don't edit this file, use the source template instead
#
#                 ANY CHANGES HERE WILL BE LOST !
#
####################################################################


use v5.14;
use warnings;
use Future::AsyncAwait;

package Sys::Async::Virt::Network v10.3.0;

use Carp qw(croak);
use Log::Any qw($log);

use Protocol::Sys::Virt::Remote::XDR v10.3.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

use constant {
    XML_INACTIVE              => (1 << 0),
    UPDATE_COMMAND_NONE       => 0,
    UPDATE_COMMAND_MODIFY     => 1,
    UPDATE_COMMAND_DELETE     => 2,
    UPDATE_COMMAND_ADD_LAST   => 3,
    UPDATE_COMMAND_ADD_FIRST  => 4,
    SECTION_NONE              => 0,
    SECTION_BRIDGE            => 1,
    SECTION_DOMAIN            => 2,
    SECTION_IP                => 3,
    SECTION_IP_DHCP_HOST      => 4,
    SECTION_IP_DHCP_RANGE     => 5,
    SECTION_FORWARD           => 6,
    SECTION_FORWARD_INTERFACE => 7,
    SECTION_FORWARD_PF        => 8,
    SECTION_PORTGROUP         => 9,
    SECTION_DNS_HOST          => 10,
    SECTION_DNS_TXT           => 11,
    SECTION_DNS_SRV           => 12,
    UPDATE_AFFECT_CURRENT     => 0,
    UPDATE_AFFECT_LIVE        => 1 << 0,
    UPDATE_AFFECT_CONFIG      => 1 << 1,
    EVENT_DEFINED             => 0,
    EVENT_UNDEFINED           => 1,
    EVENT_STARTED             => 2,
    EVENT_STOPPED             => 3,
    PORT_CREATE_RECLAIM       => (1 << 0),
    PORT_CREATE_VALIDATE      => (1 << 1),
    METADATA_DESCRIPTION      => 0,
    METADATA_TITLE            => 1,
    METADATA_ELEMENT          => 2,
};


sub new {
    my ($class, %args) = @_;
    return bless {
        id => $args{id},
        client => $args{client},
    }, $class;
}

sub create {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_CREATE,
        { net => $self->{id},  } );
}

sub destroy {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_DESTROY,
        { net => $self->{id},  } );
}

sub get_autostart {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_GET_AUTOSTART,
        { net => $self->{id},  } );
}

sub get_bridge_name {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_GET_BRIDGE_NAME,
        { net => $self->{id},  } );
}

sub get_metadata {
    my ($self, $type, $uri, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_GET_METADATA,
        { network => $self->{id}, type => $type, uri => $uri, flags => $flags // 0 } );
}

sub get_xml_desc {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_GET_XML_DESC,
        { net => $self->{id}, flags => $flags // 0 } );
}

sub is_active {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_IS_ACTIVE,
        { net => $self->{id},  } );
}

sub is_persistent {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_IS_PERSISTENT,
        { net => $self->{id},  } );
}

sub list_all_ports {
    my ($self, $need_results, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_LIST_ALL_PORTS,
        { network => $self->{id}, need_results => $need_results, flags => $flags // 0 } );
}

sub port_create_xml {
    my ($self, $xml, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_PORT_CREATE_XML,
        { network => $self->{id}, xml => $xml, flags => $flags // 0 } );
}

sub port_lookup_by_uuid {
    my ($self, $uuid) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_PORT_LOOKUP_BY_UUID,
        { network => $self->{id}, uuid => $uuid } );
}

sub set_autostart {
    my ($self, $autostart) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_SET_AUTOSTART,
        { net => $self->{id}, autostart => $autostart } );
}

sub set_metadata {
    my ($self, $type, $metadata, $key, $uri, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_SET_METADATA,
        { network => $self->{id}, type => $type, metadata => $metadata, key => $key, uri => $uri, flags => $flags // 0 } );
}

sub undefine {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_UNDEFINE,
        { net => $self->{id},  } );
}

sub update {
    my ($self, $command, $section, $parentIndex, $xml, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_NETWORK_UPDATE,
        { net => $self->{id}, command => $command, section => $section, parentIndex => $parentIndex, xml => $xml, flags => $flags // 0 } );
}



1;


__END__


=head1 NAME

Sys::Async::Virt::Network - Client side proxy to remote LibVirt network

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EVENTS

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS

=head2 create

  $serial = $client->create;
  # -> (* no data *)

=head2 destroy

  $serial = $client->destroy;
  # -> (* no data *)

=head2 get_autostart

  $serial = $client->get_autostart;
  # -> { autostart => $autostart }

=head2 get_bridge_name

  $serial = $client->get_bridge_name;
  # -> { name => $name }

=head2 get_metadata

  $serial = $client->get_metadata( $type, $uri, $flags = 0 );
  # -> { metadata => $metadata }

=head2 get_xml_desc

  $serial = $client->get_xml_desc( $flags = 0 );
  # -> { xml => $xml }

=head2 is_active

  $serial = $client->is_active;
  # -> { active => $active }

=head2 is_persistent

  $serial = $client->is_persistent;
  # -> { persistent => $persistent }

=head2 list_all_ports

  $serial = $client->list_all_ports( $need_results, $flags = 0 );
  # -> { ports => $ports, ret => $ret }

=head2 port_create_xml

  $serial = $client->port_create_xml( $xml, $flags = 0 );
  # -> { port => $port }

=head2 port_lookup_by_uuid

  $serial = $client->port_lookup_by_uuid( $uuid );
  # -> { port => $port }

=head2 set_autostart

  $serial = $client->set_autostart( $autostart );
  # -> (* no data *)

=head2 set_metadata

  $serial = $client->set_metadata( $type, $metadata, $key, $uri, $flags = 0 );
  # -> (* no data *)

=head2 undefine

  $serial = $client->undefine;
  # -> (* no data *)

=head2 update

  $serial = $client->update( $command, $section, $parentIndex, $xml, $flags = 0 );
  # -> (* no data *)


=head1 CONSTANTS

=over 8

XML_INACTIVE

=item UPDATE_COMMAND_NONE

=item UPDATE_COMMAND_MODIFY

=item UPDATE_COMMAND_DELETE

=item UPDATE_COMMAND_ADD_LAST

=item UPDATE_COMMAND_ADD_FIRST

=item SECTION_NONE

=item SECTION_BRIDGE

=item SECTION_DOMAIN

=item SECTION_IP

=item SECTION_IP_DHCP_HOST

=item SECTION_IP_DHCP_RANGE

=item SECTION_FORWARD

=item SECTION_FORWARD_INTERFACE

=item SECTION_FORWARD_PF

=item SECTION_PORTGROUP

=item SECTION_DNS_HOST

=item SECTION_DNS_TXT

=item SECTION_DNS_SRV

=item UPDATE_AFFECT_CURRENT

=item UPDATE_AFFECT_LIVE

=item UPDATE_AFFECT_CONFIG

=item EVENT_DEFINED

=item EVENT_UNDEFINED

=item EVENT_STARTED

=item EVENT_STOPPED

=item PORT_CREATE_RECLAIM

=item PORT_CREATE_VALIDATE

=item METADATA_DESCRIPTION

=item METADATA_TITLE

=item METADATA_ELEMENT

=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

