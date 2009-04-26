use strict;
use warnings;
use Test::More tests => 6;
use Test::Exception;

use ok 'PleasureChicken::Schema::Address';

my $jrock;
lives_ok {
    $jrock = PleasureChicken::Schema::Address->new(
        address => 'jon+nospam@jrock.us',
    );
};

is $jrock->user_part, 'jon+nospam';
is $jrock->user, 'jon';
is $jrock->subuser, 'nospam';
is $jrock->domain, 'jrock.us';
