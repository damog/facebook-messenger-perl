use strict;
use warnings;

use Facebook::Messenger::Bot;

use constant VERIFY_TOKEN => 'iwishiwaswritingthisinperl6';

my $bot = Facebook::Messenger::Bot->new(); # no config specified!

$bot->expect_verify_token( VERIFY_TOKEN );

$bot->spin();
