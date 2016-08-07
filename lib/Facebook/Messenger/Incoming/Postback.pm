package Facebook::Messenger::Incoming::Postback;

use strict;
use warnings;

use Data::Dumper;

sub new {
    my $self = shift;
    my $payload = shift;

    return bless $payload, $self;
}

# XXX: do this more smartly :)
sub sender {
    my $self = shift;
    return $self->{sender};
}

sub sender_id {
    my $self = shift;
    return $self->sender->{id};
}

sub recipient {
    my $self = shift;
    return $self->{recipient};
}

sub recipient_id {
    my $self = shift;
    return $self->recipient->{id};
}

sub timestamp {
    my $self = shift;
    return $self->{timestamp}
}

sub postback {
    my $self = shift;
    return $self->{postback};
}

sub payload {
    my $self = shift;
    return $self->postback->{payload};
}

sub type { 'postback' }

1;
