package Facebook::Messenger::Request;

use strict;
use warnings;

use Data::Dumper;
use LWP::UserAgent;
use base 'HTTP::Request';

my $base_uri = 'https://graph.facebook.com/v2.6/me/messages';

sub new {
    my $self = shift;
    my $method = 'POST';

    return $self->SUPER::new($method, $base_uri);
}

sub access_token {
    my $self = shift;
    if ( my $access_token = shift ) {
        $self->{_access_token} = $access_token;
    } # XXX: param checking :)

    $self->{_access_token};
}

sub execute {
    # finalize token:
    my $self = shift;

    $self->uri( $base_uri . '?access_token=' . $self->access_token );
    $self->header('Content-Type' => 'application/json');

    my $ua = LWP::UserAgent->new( agent => 'facebook-messenger-perl/0.1' );

    my $res = $ua->request( $self );

    die Dumper $res;

}

1;
