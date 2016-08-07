package Facebook::Messenger::Incoming::Optin;

use strict;
use warnings;

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
    return $self->recipient->{recipient_id};
}

sub timestamp { $_[0]->{timestamp} }

sub optin {
    my $self = shift;
    return $self->{optin}
}

sub ref { # convenience
    my $self = shift;
    return $self->optin->{ref}
}

sub type { 'optin' }

1;
