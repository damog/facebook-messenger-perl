use strict;
use warnings;

use JSON;
use Data::Dumper;
use Facebook::Messenger::Bot;
use LWP::Simple 'get';

my $recipient_id = $ARGV[0] || '1202397443144853'; # fb.com/damog :)

my $fb = Facebook::Messenger::Bot->new;
$fb->read_config('config.ini'); # just gathering the access token
                                # XXX: improve this bit?

for my $str (
    "Here is your daily quote!",
    decode_json( get 'http://quotesondesign.com/api/3.0/api-3.0.json' )->{quote}
) {
    my $ref = {
        recipient => { id => $recipient_id },
        message => { text => $str }
    };

    my $res = $fb->deliver($ref);

    print STDERR Dumper $res;
}
