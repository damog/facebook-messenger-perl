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

    if ( $message->text =~ /hello/i ) {
        $bot->deliver({
            recipient => { id => $message->sender_id },
            message => { text => "Hey dude, what's up?" }
        });
    } elsif ( $message->text =~ /America/i ) {
        $bot->deliver({
            recipient => { id => $message->sender_id },
            message => { text => 'You seem to want to make America great again!' }
        });

        show_random_picture($bot, $message->sender_id);

    }
});

# might be better to make a hook specially for quick reply payloads
$bot->register_hook_for('message', sub {
    my $bot = shift;
    my $message = shift;

    if ( defined $message->{message}->{quick_reply} ) {
        my $payload = $message->{message}->{quick_reply}->{payload};
        my $reply = '';
        my $try_harder = 0;

        if ( $payload eq 'RANDOM_IMAGE_HELP_YES' ) {
            $reply = 'Glad it helped!';
        } elsif ( $payload eq 'RANDOM_IMAGE_HELP_NO' ) {
            $reply = "I'll try harder next time!";
            $try_harder = 1;
        } else {
            die 'Unsupported payload!';
        }

        $bot->deliver({
            recipient => { id => $message->sender_id },
            message => { text => $reply }
        });

        if ( $try_harder ) {
            $bot->deliver({
                recipient => { id => $message->sender_id },
                message => {
                    attachment => {
                        type => 'template',
                        payload => {
                            template_type => 'button',
                            text => 'What would you like to do?',
                            buttons => [
                                {
                                    type => 'web_url',
                                    url => 'https://damog.net',
                                    title => "Go to David's site!",
                                },
                                {
                                    type => 'postback',
                                    title => 'See new image!',
                                    payload => 'RANDOM_IMAGE_MENU',
                                }
                            ]
                        }
                    }
                }
            });
        }
    }
});

$bot->register_hook_for('postback', sub {
    my $bot = shift;
    my $message = shift;

    if ( $message->payload eq 'RANDOM_IMAGE_MENU' ) {
        show_random_picture($bot, $message->sender_id);
    }
});

sub show_random_picture {
    my $bot = shift;
    my $sender_id = shift;

    $bot->deliver({
        recipient => { id => $sender_id },
        message => { attachment => {
            type => 'image',
            payload => { url => 'http://lorempixel.com/400/200/' }
        }}
    });

    $bot->deliver({
        recipient => { id => $sender_id },
        message => {
            text => 'Does this help?',
            quick_replies => [
                {
                    content_type => 'text',
                    title => 'Yes!',
                    payload => 'RANDOM_IMAGE_HELP_YES'
                },
                {
                    content_type => 'text',
                    title => 'No :(',
                    payload => 'RANDOM_IMAGE_HELP_NO'
                }
            ]
        }
    });
}

$bot->spin({ verbose => 1 });
