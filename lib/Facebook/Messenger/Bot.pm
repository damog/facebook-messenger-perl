package Facebook::Messenger::Bot;

use strict;
use warnings;

use JSON;
use Data::Dumper;
use Plack::Request;
use Plack::Response;

use Facebook::Messenger::Bot::Hook;
use Facebook::Messenger::Request;

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

sub deliver {
    my $self = shift;
    my $args = shift;

    my $req = Facebook::Messenger::Request->new;
    $req->content( encode_json( $args )); # XXX: proper sanitization :)
    $req->access_token( $self->{_config}->{access_token} );

    my $foo = $req->execute();

    die Dumper $req;



}

1;
