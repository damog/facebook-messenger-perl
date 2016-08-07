package Facebook::Messenger::Incoming;

use strict;
use warnings;

use Data::Dumper;

use Facebook::Messenger::Incoming::Message;
use Facebook::Messenger::Incoming::Delivery;

my $event_types = {
    'message'           => 'Message',
    'delivery'          => 'Delivery',
    # 'postback'          => 'Postback',
    # 'optin'             => 'Optin',
    # 'read'              => 'Read',
    # 'account_linking'   => 'AccountLinking'
};

sub receive {
    my $self = shift;
    my $payload = shift;

    for my $event ( keys %$event_types ) {
        next unless $payload->{ $event };
        return "Facebook::Messenger::Incoming::$event_types->{$event}"->new($payload);
    }
}

1;
