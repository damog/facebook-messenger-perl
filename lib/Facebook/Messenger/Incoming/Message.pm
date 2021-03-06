package Facebook::Messenger::Incoming::Message;

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

sub message {
    my $self = shift;
    return $self->{message};
}

sub text {
    my $self = shift;
    return $self->message->{text};
}

sub mid {
    my $self = shift;
    return $self->{mid};
}

sub id {
    my $self = shift;
    return $self->mid;
}

sub type { 'message' }

1;
