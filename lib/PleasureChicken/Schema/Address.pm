use MooseX::Declare;

class PleasureChicken::Schema::Address with KiokuDB::Role::ID with KiokuDB::Role::Immutable {
    use PleasureChicken::Schema::Types qw(PlainEmailAddress);
    use MooseX::Types::Moose qw(Str);
    use namespace::autoclean;

    has 'address' => (
        is       => 'ro',
        isa      => PlainEmailAddress,
        required => 1,
    );

    has 'user_part' => (
        is         => 'ro',
        isa        => Str,
        lazy_build => 1,
    );

    has 'user' => (
        is         => 'ro',
        isa        => Str,
        lazy_build => 1,
    );

    has 'subuser' => (
        is         => 'ro',
        isa        => Str,
        lazy_build => 1,
    );

    has 'domain' => (
        is         => 'ro',
        isa        => Str,
        lazy_build => 1,
    );

    method _build_user_part {
        my ($user, $host) = split /@/, $self->address;
        return $user;
    }

    method _build_domain {
        my ($user, $host) = split /@/, $self->address;
        return $host;
    }

    method _build_user {
        my ($user, @rest) = split /[+-]/, $self->user_part;
        return $user;
    }

    method _build_subuser {
        my ($user, $delim, @rest) = split /([+-])/, $self->user_part;
        return join '', @rest;
    }

    method kiokudb_object_id() {
        return 'address:'.$self->address;
    }

}

1;
