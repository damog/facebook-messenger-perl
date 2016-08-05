package Facebook::Messenger::Bot;

use strict;
use warnings;

use Plack::Request;

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

sub spin { #basically a server
    my $self = shift;

    sub {
        my $env = shift;

        my $req = Plack::Request->new($env);

        # ...
        return [ '200',
                [ 'Content-Type' => 'text/plain' ],
                [ "Hello World!!\n" ]
        ];
    }
}

1;
