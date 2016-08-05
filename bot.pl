use strict;
use warnings;

use Facebook::Messenger::Bot;

my $bot = Facebook::Messenger::Bot->new({
	access_token   => '...',
	app_secret     => '...',
	verify_token   => '...'
});

$bot->register_callback_for('message', sub {
	my $bot = shift;
	my $message = shift;

	my $res = $bot->deliver({
		recipient => $message->sender,
		message => 'what up!'
	});
	...
});

$bot->spin();
