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

sub build {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_BUILD,
        { pool => $self->{id}, flags => $flags // 0 } );
}

sub create {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_CREATE,
        { pool => $self->{id}, flags => $flags // 0 } );
}

sub delete {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_DELETE,
        { pool => $self->{id}, flags => $flags // 0 } );
}

sub destroy {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_DESTROY,
        { pool => $self->{id},  } );
}

sub get_autostart {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_GET_AUTOSTART,
        { pool => $self->{id},  } );
}

sub get_info {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_GET_INFO,
        { pool => $self->{id},  } );
}

sub get_xml_desc {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_GET_XML_DESC,
        { pool => $self->{id}, flags => $flags // 0 } );
}

sub is_active {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_IS_ACTIVE,
        { pool => $self->{id},  } );
}

sub is_persistent {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_IS_PERSISTENT,
        { pool => $self->{id},  } );
}

sub list_all_volumes {
    my ($self, $need_results, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_LIST_ALL_VOLUMES,
        { pool => $self->{id}, need_results => $need_results, flags => $flags // 0 } );
}

sub list_volumes {
    my ($self, $maxnames) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_LIST_VOLUMES,
        { pool => $self->{id}, maxnames => $maxnames } );
}

sub num_of_volumes {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_NUM_OF_VOLUMES,
        { pool => $self->{id},  } );
}

sub refresh {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_REFRESH,
        { pool => $self->{id}, flags => $flags // 0 } );
}

sub set_autostart {
    my ($self, $autostart) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_SET_AUTOSTART,
        { pool => $self->{id}, autostart => $autostart } );
}

sub undefine {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_UNDEFINE,
        { pool => $self->{id},  } );
}

sub vol_create_xml {
    my ($self, $xml, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_CREATE_XML,
        { pool => $self->{id}, xml => $xml, flags => $flags // 0 } );
}

sub vol_create_xml_from {
    my ($self, $xml, $clonevol, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_CREATE_XML_FROM,
        { pool => $self->{id}, xml => $xml, clonevol => $clonevol, flags => $flags // 0 } );
}

sub vol_lookup_by_name {
    my ($self, $name) = @_;
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

  $serial = $client->build( $flags = 0 );
  # -> (* no data *)

=head2 create

  $serial = $client->create( $flags = 0 );
  # -> (* no data *)

=head2 delete

  $serial = $client->delete( $flags = 0 );
  # -> (* no data *)

=head2 destroy

  $serial = $client->destroy;
  # -> (* no data *)

=head2 get_autostart

  $serial = $client->get_autostart;
  # -> { autostart => $autostart }

=head2 get_info

  $serial = $client->get_info;
  # -> { allocation => $allocation, available => $available, capacity => $capacity, state => $state }

=head2 get_xml_desc

  $serial = $client->get_xml_desc( $flags = 0 );
  # -> { xml => $xml }

=head2 is_active

  $serial = $client->is_active;
  # -> { active => $active }

=head2 is_persistent

  $serial = $client->is_persistent;
  # -> { persistent => $persistent }

=head2 list_all_volumes

  $serial = $client->list_all_volumes( $need_results, $flags = 0 );
  # -> { ret => $ret, vols => $vols }

=head2 list_volumes

  $serial = $client->list_volumes( $maxnames );
  # -> { names => $names }

=head2 num_of_volumes

  $serial = $client->num_of_volumes;
  # -> { num => $num }

=head2 refresh

  $serial = $client->refresh( $flags = 0 );
  # -> (* no data *)

=head2 set_autostart

  $serial = $client->set_autostart( $autostart );
  # -> (* no data *)

=head2 undefine

  $serial = $client->undefine;
  # -> (* no data *)

=head2 vol_create_xml

  $serial = $client->vol_create_xml( $xml, $flags = 0 );
  # -> { vol => $vol }

=head2 vol_create_xml_from

  $serial = $client->vol_create_xml_from( $xml, $clonevol, $flags = 0 );
  # -> { vol => $vol }

=head2 vol_lookup_by_name

  $serial = $client->vol_lookup_by_name( $name );
  # -> { vol => $vol }


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

