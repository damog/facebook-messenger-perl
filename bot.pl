# ~/git_tree/facebook-messenger-perl (master) > plackup -MData::Dumper -Ilib -L Shotgun -S Starman bot.pl

use strict;
use warnings;

use Data::Dumper;

use Facebook::Messenger::Bot;

my $bot = Facebook::Messenger::Bot->new();
$bot->read_config('config.ini');

$bot->register_hook_for('message', sub {
	my $bot = shift;
	my $message = shift;

	my $res = $bot->deliver({
		recipient => $message->sender,
		message => { text => "Are you sure? " . reverse( $message->text ) }
	});
	# ...
});

$bot->spin({verbose => 1});
