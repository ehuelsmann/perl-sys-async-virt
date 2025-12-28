####################################################################
#
#     This file was generated using XDR::Parse version v0.3.1
#                   and LibVirt version v11.10.0
#
#      Don't edit this file, use the source template instead
#
#                 ANY CHANGES HERE WILL BE LOST !
#
####################################################################


use v5.26;
use warnings;
no warnings qw(void);
use experimental 'signatures';
use Future::AsyncAwait;
use Object::Pad 0.821;
#use Sublike::Extended 0.29 'method', 'sub'; # From XS-Parse-Sublike, used by Future::AsyncAwait

class Sys::Async::Virt v0.1.10;

# inheriting from IO::Async::Notifier (a non-Object::Pad base class) implies ':repr(HASH)'
inherit IO::Async::Notifier;


field $_transport;


async method _dispatch_data( $f ) {
    my $data;
    if (my @dispatch_values = $transport->receive($data)) {
    }
}

async method domain_event_register_any($eventID, $domain = undef) {
}

1;
