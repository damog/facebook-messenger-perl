package Facebook::Messenger::Utils;

require Exporter;
our @ISA = ("Exporter");

use strict;
use warnings;

use Data::Dumper;

our @EXPORT = ('dump_http', 'dump');

sub dump_http {
    my $obj = shift;

    if ( ref $obj eq 'Plack::Request' ) {
        print STDERR $obj->uri, "\n";
        print STDERR $obj->headers->as_string, "\n";
        print STDERR $obj->content, "\n\n";
    } elsif ( ref $obj eq 'Plack::Response' ) {
        print STDERR $obj->status, "\n";
        print STDERR $obj->headers->as_string, "\n";
        print STDERR $obj->body || '<NO BODY>', "\n\n";
    } else {
        Carp::croak "Unsupported object in dump_http";
    }
}

sub dump {
    my $t = shift;
    print STDERR $t, "\n";
}

1;
