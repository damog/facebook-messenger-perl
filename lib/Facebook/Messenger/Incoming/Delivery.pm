package Facebook::Messenger::Incoming::Delivery;

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

sub mids {
    my $self = shift;
    return $self->{delivery}->{mids};
}

sub seq {
    my $self = shift;
    return $self->{delivery}->{seq};
}

sub at {
    # do it with a DateTime object? :/
    my $self = shift;
    return $self->watermark;
}

sub watermark {
    my $self = shift;
    $self->{delivery}->{watermark};
}

sub type { 'delivery' }

1;
