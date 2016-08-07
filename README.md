# Perl bindings for the Facebook Messenger API

This is currently a work in progress to implement the [Facebook Messenger
API](https://developers.facebook.com/docs/messenger-platform) for friendly Perl usage :)

So far this is a quick example of what you can build:

<p align="center">
    <img src="https://github.com/damog/facebook-messenger-perl/blob/master/media/sample-01.gif?raw=true">
</p>

The source code for that example is on the `reply-bot.pl` example [here](https://github.com/damog/facebook-messenger-perl/blob/master/examples/reply-bot.pl).

But basically the interface should be super simple and clean with something like this:

```perl
# bot.pl
use Facebook::Messenger::Bot;

my $bot = Facebook::Messenger::Bot->new({
	access_token   => '...',
	app_secret     => '...',
	verify_token   => '...'
});

$bot->register_hook_for('message', sub {
	my $bot = shift;
	my $message = shift;

	my $res = $bot->deliver({
		recipient => $message->sender,
		message => { text => "You said: " . $message->text() }
	});

$bot->register_hook_for('postback', sub {
    my $bot = shift;
    my $postback = shift;

    # ... do things here
}

$bot->spin();
```

The actual spinning, you can hook up to whatever framework or application that supports [PSGI/Plack](http://plackperl.org/), with something like:

`> plackup -S Starman bot.pl`

...to make your webhook accessible to Facebook with whatever method
you feel most comfortable with :)

This work is mildly and loosely based on [this](https://github.com/hyperoslo/facebook-messenger).

### Author
[David Moreno](https://damog.net).

# This is massively incomplete anyway

Thanks for looking :)
