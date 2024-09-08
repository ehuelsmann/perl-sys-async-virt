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

package Sys::Async::Virt::DomainSnapshot v10.3.0;

use Carp qw(croak);
use Log::Any qw($log);

use Protocol::Sys::Virt::Remote::XDR v10.3.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

use constant {
    XML_SECURE           => (1 << 0),
    LIST_ROOTS           => (1 << 0),
    LIST_DESCENDANTS     => (1 << 0),
    LIST_LEAVES          => (1 << 2),
    LIST_NO_LEAVES       => (1 << 3),
    LIST_METADATA        => (1 << 1),
    LIST_NO_METADATA     => (1 << 4),
    LIST_INACTIVE        => (1 << 5),
    LIST_ACTIVE          => (1 << 6),
    LIST_DISK_ONLY       => (1 << 7),
    LIST_INTERNAL        => (1 << 8),
    LIST_EXTERNAL        => (1 << 9),
    LIST_TOPOLOGICAL     => (1 << 10),
    REVERT_RUNNING       => 1 << 0,
    REVERT_PAUSED        => 1 << 1,
    REVERT_FORCE         => 1 << 2,
    REVERT_RESET_NVRAM   => 1 << 3,
    DELETE_CHILDREN      => (1 << 0),
    DELETE_METADATA_ONLY => (1 << 1),
    DELETE_CHILDREN_ONLY => (1 << 2),
};


sub new {
    my ($class, %args) = @_;
    return bless {
        id => $args{id},
        client => $args{client},
    }, $class;
}

sub delete {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_DOMAIN_SNAPSHOT_DELETE,
        { snap => $self->{id}, flags => $flags // 0 } );
}

sub get_parent {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_DOMAIN_SNAPSHOT_GET_PARENT,
        { snap => $self->{id}, flags => $flags // 0 } );
}

sub get_xml_desc {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_DOMAIN_SNAPSHOT_GET_XML_DESC,
        { snap => $self->{id}, flags => $flags // 0 } );
}

sub has_metadata {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_DOMAIN_SNAPSHOT_HAS_METADATA,
        { snap => $self->{id}, flags => $flags // 0 } );
}

sub is_current {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_DOMAIN_SNAPSHOT_IS_CURRENT,
        { snap => $self->{id}, flags => $flags // 0 } );
}

sub list_all_children {
    my ($self, $need_results, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_DOMAIN_SNAPSHOT_LIST_ALL_CHILDREN,
        { snapshot => $self->{id}, need_results => $need_results, flags => $flags // 0 } );
}

sub list_children_names {
    my ($self, $maxnames, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_DOMAIN_SNAPSHOT_LIST_CHILDREN_NAMES,
        { snap => $self->{id}, maxnames => $maxnames, flags => $flags // 0 } );
}

sub num_children {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_DOMAIN_SNAPSHOT_NUM_CHILDREN,
        { snap => $self->{id}, flags => $flags // 0 } );
}

sub revert_to_snapshot {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_DOMAIN_REVERT_TO_SNAPSHOT,
        { snap => $self->{id}, flags => $flags // 0 } );
}



1;


__END__

=head1 NAME

Sys::Async::Virt::DomainSnapshot - Client side proxy to remote LibVirt domain snapshot

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EVENTS

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS

=head2 delete

  $serial = $client->delete( $flags = 0 );
  # -> (* no data *)

=head2 get_parent

  $serial = $client->get_parent( $flags = 0 );
  # -> { snap => $snap }

=head2 get_xml_desc

  $serial = $client->get_xml_desc( $flags = 0 );
  # -> { xml => $xml }

=head2 has_metadata

  $serial = $client->has_metadata( $flags = 0 );
  # -> { metadata => $metadata }

=head2 is_current

  $serial = $client->is_current( $flags = 0 );
  # -> { current => $current }

=head2 list_all_children

  $serial = $client->list_all_children( $need_results, $flags = 0 );
  # -> { ret => $ret, snapshots => $snapshots }

=head2 list_children_names

  $serial = $client->list_children_names( $maxnames, $flags = 0 );
  # -> { names => $names }

=head2 num_children

  $serial = $client->num_children( $flags = 0 );
  # -> { num => $num }

=head2 revert_to_snapshot

  $serial = $client->revert_to_snapshot( $flags = 0 );
  # -> (* no data *)


=head1 CONSTANTS

=over 8

XML_SECURE

=item LIST_ROOTS

=item LIST_DESCENDANTS

=item LIST_LEAVES

=item LIST_NO_LEAVES

=item LIST_METADATA

=item LIST_NO_METADATA

=item LIST_INACTIVE

=item LIST_ACTIVE

=item LIST_DISK_ONLY

=item LIST_INTERNAL

=item LIST_EXTERNAL

=item LIST_TOPOLOGICAL

=item REVERT_RUNNING

=item REVERT_PAUSED

=item REVERT_FORCE

=item REVERT_RESET_NVRAM

=item DELETE_CHILDREN

=item DELETE_METADATA_ONLY

=item DELETE_CHILDREN_ONLY

=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

