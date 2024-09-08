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

package Sys::Async::Virt::Secret v10.3.0;

use Carp qw(croak);
use Log::Any qw($log);

use Protocol::Sys::Virt::Remote::XDR v10.3.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

use constant {
    EVENT_DEFINED   => 0,
    EVENT_UNDEFINED => 1,
};


sub new {
    my ($class, %args) = @_;
    return bless {
        id => $args{id},
        client => $args{client},
    }, $class;
}

sub get_xml_desc {
    my ($self, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_SECRET_GET_XML_DESC,
        { secret => $self->{id}, flags => $flags // 0 } );
}

sub set_value {
    my ($self, $value, $flags) = @_;
    return $self->{client}->_call(
        $remote->PROC_SECRET_SET_VALUE,
        { secret => $self->{id}, value => $value, flags => $flags // 0 } );
}

sub undefine {
    my ($self, ) = @_;
    return $self->{client}->_call(
        $remote->PROC_SECRET_UNDEFINE,
        { secret => $self->{id},  } );
}



1;


__END__

=head1 NAME

Sys::Async::Virt::Secret - Client side proxy to remote LibVirt secret

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EVENTS

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS

=head2 get_xml_desc

  $serial = $client->get_xml_desc( $flags = 0 );
  # -> { xml => $xml }

=head2 set_value

  $serial = $client->set_value( $value, $flags = 0 );
  # -> (* no data *)

=head2 undefine

  $serial = $client->undefine;
  # -> (* no data *)


=head1 CONSTANTS

=over 8

EVENT_DEFINED

=item EVENT_UNDEFINED

=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

