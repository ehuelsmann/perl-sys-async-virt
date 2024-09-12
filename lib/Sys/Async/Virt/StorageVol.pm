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

package Sys::Async::Virt::StorageVol v10.3.0;

use Carp qw(croak);
use Log::Any qw($log);

use Protocol::Sys::Virt::Remote::XDR v10.3.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

use constant {
    FILE                   => 0,
    BLOCK                  => 1,
    DIR                    => 2,
    NETWORK                => 3,
    NETDIR                 => 4,
    PLOOP                  => 5,
    DELETE_NORMAL          => 0,
    DELETE_ZEROED          => 1 << 0,
    DELETE_WITH_SNAPSHOTS  => 1 << 1,
    WIPE_ALG_ZERO          => 0,
    WIPE_ALG_NNSA          => 1,
    WIPE_ALG_DOD           => 2,
    WIPE_ALG_BSI           => 3,
    WIPE_ALG_GUTMANN       => 4,
    WIPE_ALG_SCHNEIER      => 5,
    WIPE_ALG_PFITZNER7     => 6,
    WIPE_ALG_PFITZNER33    => 7,
    WIPE_ALG_RANDOM        => 8,
    WIPE_ALG_TRIM          => 9,
    USE_ALLOCATION         => 0,
    GET_PHYSICAL           => 1 << 0,
    DOWNLOAD_SPARSE_STREAM => 1 << 0,
    UPLOAD_SPARSE_STREAM   => 1 << 0,
    RESIZE_ALLOCATE        => 1 << 0,
    RESIZE_DELTA           => 1 << 1,
    RESIZE_SHRINK          => 1 << 2,
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
        $remote->PROC_STORAGE_VOL_DELETE,
        { vol => $self->{id}, flags => $flags // 0 } );
}

sub download($self, $offset, $length, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_DOWNLOAD,
        { vol => $self->{id}, offset => $offset, length => $length, flags => $flags // 0 } );
}

sub get_info($self) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_GET_INFO,
        { vol => $self->{id},  } );
}

sub get_path($self) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_GET_PATH,
        { vol => $self->{id},  } );
}

sub get_xml_desc($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_GET_XML_DESC,
        { vol => $self->{id}, flags => $flags // 0 } );
}

sub pool_lookup_by_volume($self) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_POOL_LOOKUP_BY_VOLUME,
        { vol => $self->{id},  } );
}

sub resize($self, $capacity, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_RESIZE,
        { vol => $self->{id}, capacity => $capacity, flags => $flags // 0 } );
}

sub upload($self, $offset, $length, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_UPLOAD,
        { vol => $self->{id}, offset => $offset, length => $length, flags => $flags // 0 } );
}

sub wipe($self, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_WIPE,
        { vol => $self->{id}, flags => $flags // 0 } );
}

sub wipe_pattern($self, $algorithm, $flags = 0) {
    return $self->{client}->_call(
        $remote->PROC_STORAGE_VOL_WIPE_PATTERN,
        { vol => $self->{id}, algorithm => $algorithm, flags => $flags // 0 } );
}



1;


__END__

=head1 NAME

Sys::Async::Virt::StorageVol - Client side proxy to remote LibVirt storage volume

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EVENTS

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS

=head2 delete

  await $vol->delete( $flags = 0 );
  # -> (* no data *)

=head2 download

  await $vol->download( $offset, $length, $flags = 0 );
  # -> (* no data *)

=head2 get_info

  await $vol->get_info( $self );
  # -> { allocation => $allocation,
  #      capacity => $capacity,
  #      type => $type }

=head2 get_path

  $name = await $vol->get_path( $self );

=head2 get_xml_desc

  $xml = await $vol->get_xml_desc( $flags = 0 );

=head2 pool_lookup_by_volume

  $pool = await $vol->pool_lookup_by_volume( $self );

=head2 resize

  await $vol->resize( $capacity, $flags = 0 );
  # -> (* no data *)

=head2 upload

  await $vol->upload( $offset, $length, $flags = 0 );
  # -> (* no data *)

=head2 wipe

  await $vol->wipe( $flags = 0 );
  # -> (* no data *)

=head2 wipe_pattern

  await $vol->wipe_pattern( $algorithm, $flags = 0 );
  # -> (* no data *)


=head1 CONSTANTS

=over 8

FILE

=item BLOCK

=item DIR

=item NETWORK

=item NETDIR

=item PLOOP

=item DELETE_NORMAL

=item DELETE_ZEROED

=item DELETE_WITH_SNAPSHOTS

=item WIPE_ALG_ZERO

=item WIPE_ALG_NNSA

=item WIPE_ALG_DOD

=item WIPE_ALG_BSI

=item WIPE_ALG_GUTMANN

=item WIPE_ALG_SCHNEIER

=item WIPE_ALG_PFITZNER7

=item WIPE_ALG_PFITZNER33

=item WIPE_ALG_RANDOM

=item WIPE_ALG_TRIM

=item USE_ALLOCATION

=item GET_PHYSICAL

=item DOWNLOAD_SPARSE_STREAM

=item UPLOAD_SPARSE_STREAM

=item RESIZE_ALLOCATE

=item RESIZE_DELTA

=item RESIZE_SHRINK

=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

