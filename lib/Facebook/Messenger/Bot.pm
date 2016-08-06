package Facebook::Messenger::Bot;

use strict;
use warnings;

use Data::Dumper;
use Plack::Request;
use Plack::Response;

use Facebook::Messenger::Bot::Hook;

sub new {
    my $self = shift;
    my $params = shift;

    return bless { _config => $params }, $self;
}

sub register_hook_for {
    my $self = shift;

    my $hook = Facebook::Messenger::Bot::Hook->new(
        { type => $_[0], call => $_[1] }
    );

    # XXX: Validate inputs ;)

    push @{ $self->{_hooks} }, $hook;

    return $hook;
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
