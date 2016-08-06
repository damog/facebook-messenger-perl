package Facebook::Messenger::Bot::Hook;

use strict;
use warnings;

use Data::Dumper;

sub new {
    my $self = shift;
    my $args = shift;

    return bless $args, $self;
}

sub type {
    # XXX: Validate types
    my $self = shift;

    if (my $type = shift) {
        $self->{type} = $type;
    }
    return $self->{type};
}

1;
