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
    my $args = shift || {};

    sub {
        my $env = shift;

        require Facebook::Messenger::Bot::Server;
        my $s = Facebook::Messenger::Bot::Server->new({
            bot => $self,
            env => $env,
            %$args
        });

        return $s->process();
    }
}

sub deliver {
    my $self = shift;
    my $args = shift;

    my $req = Facebook::Messenger::Request->new;
    $req->content( encode_json( $args )); # XXX: proper sanitization :)
    $req->access_token( $self->{_config}->{access_token} );

    my $foo = $req->execute();
    # die Dumper $req;
}

sub expect_verify_token {
    my $self = shift;
    my $token = shift;

    $self->{_expect_verify_token} = $token;
}

sub _is_expecting_token_verification {
    my $self = shift;
    $self->{_expect_verify_token} ? $self->{_expect_verify_token} : undef;
}

sub read_config {
    my $self = shift;
    my $file = shift;

    Carp::croak "I can't read $file!" unless -r $file;

    require Config::Tiny;
    my $config = Config::Tiny->read( $file );

    for my $key ( keys %{ $config->{_} } ) {
        $self->{_config}->{$key} = $config->{_}->{$key};
    }

    return $self->{_config};
}

1;
