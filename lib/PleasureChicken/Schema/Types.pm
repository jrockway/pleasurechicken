package PleasureChicken::Schema::Types;
use strict;
use warnings;

use MooseX::Types -declare => [qw/PlainEmailAddress/];
use MooseX::Types::Moose qw(Str);

subtype PlainEmailAddress, as Str, where { /\@/ };

1;
