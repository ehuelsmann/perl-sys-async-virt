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

package Sys::Async::Virt::StoragePool v10.3.0;

use Carp qw(croak);
use Log::Any qw($log);

use Protocol::Sys::Virt::Remote::XDR v10.3.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

use constant {
    INACTIVE           => 0,
    BUILDING           => 1,
    RUNNING            => 2,
    DEGRADED           => 3,
    INACCESSIBLE       => 4,
    BUILD_NEW          => 0,
    BUILD_REPAIR       => (1 << 0),
    BUILD_RESIZE       => (1 << 1),
    BUILD_NO_OVERWRITE => (1 << 2),
    BUILD_OVERWRITE    => (1 << 3),
    DELETE_NORMAL      => 0,
    DELETE_ZEROED      => 1 << 0,
    XML_INACTIVE       => (1 << 0),
    EVENT_DEFINED      => 0,
    EVENT_UNDEFINED    => 1,
    EVENT_STARTED      => 2,
    EVENT_STOPPED      => 3,
    EVENT_CREATED      => 4,
    EVENT_DELETED      => 5,
};


sub new {
    my ($class, %args) = @_;
    return bless {
        id => $args{id},
        client => $args{client},
    }, $class;
}

sub build($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_BUILD,
        { pool => $self->{id}, flags => $flags // 0 } );
}

sub create($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_CREATE,
        { pool => $self->{id}, flags => $flags // 0 } );
}

sub delete($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_DELETE,
        { pool => $self->{id}, flags => $flags // 0 } );
}

sub destroy($self) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_DESTROY,
        { pool => $self->{id},  } );
}

sub get_autostart($self) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_GET_AUTOSTART,
        { pool => $self->{id},  } );
}

sub get_info($self) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_GET_INFO,
        { pool => $self->{id},  } );
}

sub get_xml_desc($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_GET_XML_DESC,
        { pool => $self->{id}, flags => $flags // 0 } );
}

sub is_active($self) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_IS_ACTIVE,
        { pool => $self->{id},  } );
}

sub is_persistent($self) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_IS_PERSISTENT,
        { pool => $self->{id},  } );
}

sub list_all_volumes($self, $need_results, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_LIST_ALL_VOLUMES,
        { pool => $self->{id}, need_results => $need_results, flags => $flags // 0 } );
}

sub list_volumes($self, $maxnames) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_LIST_VOLUMES,
        { pool => $self->{id}, maxnames => $maxnames } );
}

sub num_of_volumes($self) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_NUM_OF_VOLUMES,
        { pool => $self->{id},  } );
}

sub refresh($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_REFRESH,
        { pool => $self->{id}, flags => $flags // 0 } );
}

sub set_autostart($self, $autostart) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_SET_AUTOSTART,
        { pool => $self->{id}, autostart => $autostart } );
}

sub undefine($self) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_UNDEFINE,
        { pool => $self->{id},  } );
}

sub vol_create_xml($self, $xml, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_CREATE_XML,
        { pool => $self->{id}, xml => $xml, flags => $flags // 0 } );
}

sub vol_create_xml_from($self, $xml, $clonevol, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_CREATE_XML_FROM,
        { pool => $self->{id}, xml => $xml, clonevol => $clonevol, flags => $flags // 0 } );
}

sub vol_lookup_by_name($self, $name) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_LOOKUP_BY_NAME,
        { pool => $self->{id}, name => $name } );
}



1;


__END__

=head1 NAME

Sys::Async::Virt::StoragePool - Client side proxy to remote LibVirt storage pool

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EVENTS

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS

=head2 build

  await $pool->build( $flags = 0 );
  # -> (* no data *)

=head2 create

  await $pool->create( $flags = 0 );
  # -> (* no data *)

=head2 delete

  await $pool->delete( $flags = 0 );
  # -> (* no data *)

=head2 destroy

  await $pool->destroy( $self );
  # -> (* no data *)

=head2 get_autostart

  $autostart = await $pool->get_autostart( $self );

=head2 get_info

  await $pool->get_info( $self );
  # -> { allocation => $allocation,
  #      available => $available,
  #      capacity => $capacity,
  #      state => $state }

=head2 get_xml_desc

  $xml = await $pool->get_xml_desc( $flags = 0 );

=head2 is_active

  $active = await $pool->is_active( $self );

=head2 is_persistent

  $persistent = await $pool->is_persistent( $self );

=head2 list_all_volumes

  $vols = await $pool->list_all_volumes( $need_results, $flags = 0 );

=head2 list_volumes

  $names = await $pool->list_volumes( $maxnames );

=head2 num_of_volumes

  $num = await $pool->num_of_volumes( $self );

=head2 refresh

  await $pool->refresh( $flags = 0 );
  # -> (* no data *)

=head2 set_autostart

  await $pool->set_autostart( $autostart );
  # -> (* no data *)

=head2 undefine

  await $pool->undefine( $self );
  # -> (* no data *)

=head2 vol_create_xml

  $vol = await $pool->vol_create_xml( $xml, $flags = 0 );

=head2 vol_create_xml_from

  $vol = await $pool->vol_create_xml_from( $xml, $clonevol, $flags = 0 );

=head2 vol_lookup_by_name

  $vol = await $pool->vol_lookup_by_name( $name );


=head1 CONSTANTS

=over 8

INACTIVE

=item BUILDING

=item RUNNING

=item DEGRADED

=item INACCESSIBLE

=item BUILD_NEW

=item BUILD_REPAIR

=item BUILD_RESIZE

=item BUILD_NO_OVERWRITE

=item BUILD_OVERWRITE

=item DELETE_NORMAL

=item DELETE_ZEROED

=item XML_INACTIVE

=item EVENT_DEFINED

=item EVENT_UNDEFINED

=item EVENT_STARTED

=item EVENT_STOPPED

=item EVENT_CREATED

=item EVENT_DELETED

=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

