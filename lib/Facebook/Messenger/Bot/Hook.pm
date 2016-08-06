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

sub call {
    my $self = shift;
    if ( my $call = shift ) {
        $self->{call} = $call;
    }
    return $self->{call};
}

sub execute {
    my $self = shift;
    my $bot = shift;
    my $incoming = shift;

    # XXX: what if there's no call??
    my $res = $self->call()->( $bot, $incoming );

}

1;
