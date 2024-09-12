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

sub delete($self) {
    return $self->{client}->_call(
        $remote->PROC_NWFILTER_BINDING_DELETE,
        { nwfilter => $self->{id},  } );
}

sub get_xml_desc($self, $flags = 0) {
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

  await $binding->delete( $self );
  # -> (* no data *)

=head2 get_xml_desc

  $xml = await $binding->get_xml_desc( $flags = 0 );


=head1 CONSTANTS

=over 8



=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

