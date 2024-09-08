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

package Sys::Async::Virt::NwFilterBinding v10.3.0;

use Carp qw(croak);
use Log::Any qw($log);

use Protocol::Sys::Virt::Remote::XDR v10.3.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';



sub new {
    my ($class, %args) = @_;
    return bless {
        id => $args{id},
        client => $args{client},
    }, $class;
}

sub delete {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_NWFILTER_BINDING_DELETE,
        { nwfilter => $self->{id},  } );
}

sub get_xml_desc {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_NWFILTER_BINDING_GET_XML_DESC,
        { nwfilter => $self->{id}, flags => $flags // 0 } );
}



1;

__END__

=head1 NAME

Sys::Async::Virt::NwFilterBinding - Client side proxy to remote LibVirt network filter binding

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EVENTS

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS

=head2 delete

  $serial = $client->delete;
  # -> (* no data *)

=head2 get_xml_desc

  $serial = $client->get_xml_desc( $flags = 0 );
  # -> { xml => $xml }


=head1 CONSTANTS

=over 8



=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

