package Facebook::Messenger::Bot;

use strict;
use warnings;

use Data::Dumper;
use Plack::Request;
use Plack::Response;

sub new {
    my $self = shift;
    my $params = shift;

    return bless { _config => $params }, $self;
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

        require Facebook::Messenger::Bot::Server;
        my $s = Facebook::Messenger::Bot::Server->new({
            bot => $self,
            env => $env
        });

        $s->process();
    }
}

1;
