use MooseX::Declare;

class PleasureChicken::Schema::Tag {
    use MooseX::MultiMethods;
    use PleasureChicken::Schema::Types qw(Taggable Set);
    use MooseX::Types::Moose qw(Str);
    use KiokuDB::Util qw(set);
    use namespace::autoclean;

    has 'name' => (
        is       => 'ro',
        isa      => Str,
        required => 1,
    );

    has 'applied_to_set' => (
        is       => 'ro',
        isa      => Set,
        required => 1,
        default  => sub { set() },
        handles  => {
            applied_to => 'members',
        },
    );

    # XXX: this needs to be a list, not an arrayref
    multi method apply_to(ArrayRef[Taggable] $things){
        $self->apply_to($_) for @$things;
    }

    multi method apply_to(Taggable $thingie){
        $self->applied_to_set->insert($thingie);
        $thingie->tag_set->insert($self);
    }
}

1;
