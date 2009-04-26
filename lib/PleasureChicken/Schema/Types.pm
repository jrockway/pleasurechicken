package PleasureChicken::Schema::Types;
use strict;
use warnings;

use MooseX::Types -declare => [ qw{
    PlainEmailAddress
    Taggable
    Tag
    Set
}];

use MooseX::Types::Moose qw(Str Object);
use KiokuDB::Set;

subtype PlainEmailAddress, as Str, where { /\@/ };

subtype Taggable, as Object, where {
    $_->does('PleasureChicken::Schema::Role::WithTags');
};

class_type 'PleasureChicken::Schema::Tag';
subtype Tag, as 'PleasureChicken::Schema::Tag';

subtype Set, as Object, where { $_->does('KiokuDB::Set') };

1;
