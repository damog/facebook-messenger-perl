use strict;
use warnings;

use Facebook::Messenger::Bot;
use Data::Dumper;

my $bot = Facebook::Messenger::Bot->new();
$bot->read_config('config.ini');

$bot->register_hook_for('read', sub {
    my $bot = shift;
    my $read = shift;

    print STDERR Dumper $read;
});

$bot->spin({verbose => 1});
