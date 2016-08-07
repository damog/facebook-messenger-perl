use strict;
use warnings;

use Data::Dumper;
use Facebook::Messenger::Bot;

my $bot = Facebook::Messenger::Bot->new;
$bot->read_config('config.ini');

my $res = $bot->deliver({
    recipient => { id => '1098398620209012' },
    message => {
        attachment => {
            type => 'template',
            payload => {
                template_type => 'button',
                text => 'Who do you really wish you would vote for?',
                buttons => [
                    # { type => 'postback', title => 'Donald Trump', payload => 'REPUBLICAN' },
                    { type => 'postback', title => 'Gary Johnson', payload => 'LIBERTARIAN' },
                    # { type => 'postback', title => 'Hilary Clinton', payload => 'DEMOCRAT' },
                    { type => 'postback', title => 'Jill Stein', payload => 'GREEN' }
                ]
            }
        }
    }
});

print Dumper $res;
