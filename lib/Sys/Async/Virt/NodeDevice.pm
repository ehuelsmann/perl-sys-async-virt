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

package Sys::Async::Virt::NodeDevice v10.3.0;

use Carp qw(croak);
use Log::Any qw($log);

use Protocol::Sys::Virt::Remote::XDR v10.3.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

use constant {
    XML_INACTIVE          => 1 << 0,
    UPDATE_AFFECT_CURRENT => 0,
    UPDATE_AFFECT_LIVE    => 1 << 0,
    UPDATE_AFFECT_CONFIG  => 1 << 1,
    EVENT_CREATED         => 0,
    EVENT_DELETED         => 1,
    EVENT_DEFINED         => 2,
    EVENT_UNDEFINED       => 3,
};


sub new {
    my ($class, %args) = @_;
    return bless {
        id => $args{id},
        client => $args{client},
    }, $class;
}

sub create($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_CREATE,
        { name => $self->{id}, flags => $flags // 0 } );
}

sub create_xml($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_CREATE_XML,
        { xml_desc => $self->{id}, flags => $flags // 0 } );
}

sub define_xml($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_DEFINE_XML,
        { xml_desc => $self->{id}, flags => $flags // 0 } );
}

sub destroy($self) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_DESTROY,
        { name => $self->{id},  } );
}

sub get_autostart($self) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_GET_AUTOSTART,
        { name => $self->{id},  } );
}

sub get_parent($self) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_GET_PARENT,
        { name => $self->{id},  } );
}

sub get_xml_desc($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_GET_XML_DESC,
        { name => $self->{id}, flags => $flags // 0 } );
}

sub is_active($self) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_IS_ACTIVE,
        { name => $self->{id},  } );
}

sub is_persistent($self) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_IS_PERSISTENT,
        { name => $self->{id},  } );
}

sub list_caps($self, $maxnames) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_LIST_CAPS,
        { name => $self->{id}, maxnames => $maxnames } );
}

sub lookup_by_name($self) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_LOOKUP_BY_NAME,
        { name => $self->{id},  } );
}

sub lookup_scsi_host_by_wwn($self, $wwpn, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_LOOKUP_SCSI_HOST_BY_WWN,
        { wwnn => $self->{id}, wwpn => $wwpn, flags => $flags // 0 } );
}

sub num_of_caps($self) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_NUM_OF_CAPS,
        { name => $self->{id},  } );
}

sub set_autostart($self, $autostart) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_SET_AUTOSTART,
        { name => $self->{id}, autostart => $autostart } );
}

sub undefine($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_UNDEFINE,
        { name => $self->{id}, flags => $flags // 0 } );
}

sub update($self, $xml_desc, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_NODE_DEVICE_UPDATE,
        { name => $self->{id}, xml_desc => $xml_desc, flags => $flags // 0 } );
}



1;


__END__

=head1 NAME

Sys::Async::Virt::NodeDevice - Client side proxy to remote LibVirt host device

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EVENTS

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS

=head2 create

  await $dev->create( $flags = 0 );
  # -> (* no data *)

=head2 create_xml

  $dev = await $dev->create_xml( $flags = 0 );

=head2 define_xml

  $dev = await $dev->define_xml( $flags = 0 );

=head2 destroy

  await $dev->destroy;
  # -> (* no data *)

=head2 get_autostart

  $autostart = await $dev->get_autostart;

=head2 get_parent

  $parentName = await $dev->get_parent;

=head2 get_xml_desc

  $xml = await $dev->get_xml_desc( $flags = 0 );

=head2 is_active

  $active = await $dev->is_active;

=head2 is_persistent

  $persistent = await $dev->is_persistent;

=head2 list_caps

  $names = await $dev->list_caps( $maxnames );

=head2 lookup_by_name

  $dev = await $dev->lookup_by_name;

=head2 lookup_scsi_host_by_wwn

  $dev = await $dev->lookup_scsi_host_by_wwn( $wwpn, $flags = 0 );

=head2 num_of_caps

  $num = await $dev->num_of_caps;

=head2 set_autostart

  await $dev->set_autostart( $autostart );
  # -> (* no data *)

=head2 undefine

  await $dev->undefine( $flags = 0 );
  # -> (* no data *)

=head2 update

  await $dev->update( $xml_desc, $flags = 0 );
  # -> (* no data *)


=head1 CONSTANTS

=over 8

=item XML_INACTIVE

=item UPDATE_AFFECT_CURRENT

=item UPDATE_AFFECT_LIVE

=item UPDATE_AFFECT_CONFIG

=item EVENT_CREATED

=item EVENT_DELETED

=item EVENT_DEFINED

=item EVENT_UNDEFINED

=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

