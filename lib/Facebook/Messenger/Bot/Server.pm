package Facebook::Messenger::Bot::Server;

use strict;
use warnings;

use JSON;
use Data::Dumper;
use Plack::Request;
use Plack::Response;

use Facebook::Messenger::Incoming;

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

    $res->status(200); # unless otherwise noted?
    $res->finalize;

}

sub receive {
    my $self = shift;

    my $body = $self->{_req}->content;

    if ( $self->{_bot}->{_config}->{app_secret} ) {
        $self->check_integrity( $body );
    }

    # scream something unless:
    my $events = $self->parse_events( $body );

    $self->trigger_events( $events );

}

sub trigger_events {
    my $self = shift;
    my $events = shift;

    for my $entry ( @{ $events->{entry} } ) { # yay n^2!
        for my $msg ( @{ $entry->{messaging} } ) {
            # do we want/need to log the messages received?
            my $incoming = Facebook::Messenger::Incoming->receive( $msg );

            for my $hook ( @{ $self->{_bot}->{_hooks} } ) {
                # might make more sense to use a dispatch table
                next unless $hook->type eq $incoming->type;
                # XXX: how to protect the execution?
                my $execute = $hook->execute( $self->{_bot}, $incoming );
                # XXX: what to do with $execute?

            }
        }
    }

}

sub check_integrity {
    my $self = shift;

    my $x_hub_sig = $self->{_req}->headers->header('X-Hub-Signature');

    # XXX: check the signature starts with sha1=
    # XXX: compare signatures, the Ruby library uses Rack::Utils' secure_compare

}

sub parse_events {
    my $self = shift;
    my $body = shift; # quicker to access

    my $events = decode_json( $body );

    # XXX: check for errors? :)
}

1;
