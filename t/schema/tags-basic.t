use strict;
use warnings;
use Test::More tests => 4;

use ok 'PleasureChicken::Schema::Tag';

{ package Class;
  use Moose;
  with 'PleasureChicken::Schema::Role::WithTags';

  has 'name' => ( is => 'ro' );
}

my ($pointy, $blunt, $writing_utensil, $eating_utensil, $coffee) = map {
    PleasureChicken::Schema::Tag->new( name => $_ );
} qw/pointy blunty writing_utensil eating_utensil coffee/;

my ($pencil, $keyboard, $fork, $spoon, $coffee_cup, $tea_mug, $canned_air) = map {
    Class->new( name => $_ );
} qw/pencil keyboard fork spoon coffee_cup tea_mug canned_air/;

$pencil->add_tag($pointy);
$pencil->add_tag($writing_utensil);

$keyboard->add_tag($blunt);

$eating_utensil->apply_to([$fork, $spoon, $coffee_cup, $tea_mug]);
$fork->add_tag($pointy);
$spoon->add_tag($blunt);

$coffee->apply_to($coffee_cup);

sub names(@) { sort map { $_->name } @_ }

is_deeply [names $pointy->applied_to],
          [sort qw/pencil fork/],
  'got pointy things';

is_deeply [names $eating_utensil->applied_to],
          [sort qw/fork spoon coffee_cup tea_mug/],
  'got eating utensils';

is_deeply [names $fork->tags],
          [sort qw/pointy eating_utensil/],
  'got tags for fork';

