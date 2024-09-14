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
use Feature::Compat::Try;
use Future::AsyncAwait;

package Sys::Async::Virt::Callback v10.3.0;

use Carp qw(croak);
use Future::Queue;
use Log::Any qw($log);
use Scalar::Util qw(weaken);

use Protocol::Sys::Virt::Remote::XDR v10.3.0;
my $remote = 'Protocol::Sys::Virt::Remote::XDR';

sub new {
    my ($class, %args) = @_;
    my $self = bless {
        id => $args{id},
        client => $args{client},
        deregister_call => $args{deregister_call},
        queue => Future::Queue->new(
            max_items => $args{queue_len} // 12,
            prototype => $args{factory}
            ),
    }, $class;

    weaken $self->{client};

    return $self;
}

async sub next_event($self) {
    return await $self->{queue}->shift;
}

async sub cancel($self) {
    return if $self->{cancelled};

    $self->{cancelled} = 1;
    $self->{queue}->finish;
    await $self->{client}->_call(
        $self->{deregister_call},
        { callbackID => $self->{id} });
}

sub _dispatch_event($self, $event) {
    return if $self->{cancelled};

    try {
        $self->{queue}->push($event);
    }
    catch ($e) {
        ###TODO: Rather not RETAIN here?
        $self->cancel->retain;
    }
}

sub DESTROY($self) {
    $self->cancel unless $self->{cancelled};
}


1;

__END__

=head1 NAME

Sys::Async::Virt::Callback - 

=head1 VERSION

v10.3.0

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EVENTS

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS



=head1 CONSTANTS

=over 8



=back

=head1 SEE ALSO

L<LibVirt|https://libvirt.org>, L<Sys::Virt>

=head1 LICENSE AND COPYRIGHT

