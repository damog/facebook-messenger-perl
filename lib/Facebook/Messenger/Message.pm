package Facebook::Messenger::Message;

use strict;
use warnings;

use Data::Dumper;

my $event_types = {
    'message'           => 'Message',
    'delivery'          => 'Delivery',
    'postback'          => 'Postback',
    'optin'             => 'Optin',
    'read'              => 'Read',
    'account_linking'   => 'AccountLinking'
};

sub receive {
    my $self = shift;
    my $message = shift;

    die Dumper $message;
}

1;
