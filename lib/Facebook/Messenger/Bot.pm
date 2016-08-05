package Facebook::Messenger::Bot;

use strict;
use warnings;

sub new {
    my $self = shift;
    my $params = shift;

    return bless $params, $self;
}

sub register_callback_for {
    my $self = shift;
    my $type = shift;
    my $call = shift;

    # XXX: Validate inputs ;)

    return 1;
}

sub spin {
    my $self = shift;

    sub {
        my $env = shift;
        # ...
        return [ '200',
                [ 'Content-Type' => 'text/plain' ],
                [ "Hello World" ]
        ];
    }
}

1;
