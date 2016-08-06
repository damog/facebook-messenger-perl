package Facebook::Messenger::Bot::Server;

use strict;
use warnings;

use Data::Dumper;
use Plack::Request;
use Plack::Response;

sub new {
    my $self = shift;
    my $args = shift;

    return bless {
        _bot => $args->{bot},
        _res => Plack::Response->new,
        _req => Plack::Request->new( $args->{env} ),
    }, $self;

}

sub process {
    my $self = shift;

    my $req = $self->{_req};
    my $res = $self->{_res};

    if ( $req->method eq 'GET' ) {
        $self->verify();
    } elsif ( $req->method eq 'POST' ) {
        $self->receive();
    } else {
        $res->status( 405 );
    }

    $res->finalize;

}

sub receive {
    my $self = shift;

    my $body = $self->{_req}->content;

}

1;
