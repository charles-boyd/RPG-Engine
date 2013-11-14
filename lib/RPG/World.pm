package RPG::World;

use warnings;
use strict;

use RPG::GameEntity::Character;
use RPG::GameEntity::Item::Weapon;

sub new {
    my ( $class, %params ) = @_;

    my $self =
	{
	    'characters' => [],
	    'weapons'    => [],
	};

    bless($self,$class);
    return $self;
}

sub get_entity {
    my ( $self, $p_entity ) = @_;
    return $self->{$p_entity};
}

sub get_component {
    my ( $self, $p_entity, $p_id ) = @_;
    return $self->{$p_entity}->[$p_id];
}

sub add_component {
    my ( $self, $p_entity, $p_component ) = @_;

    my $n = scalar(@{ $self->{$p_entity} });

    foreach my $i ( 0 .. ($n - 1) ) {
	if ( ! defined($self->{$p_entity}->[$i]) ) {
	    $p_component->set_id($i);
	    $self->{$p_entity}->[$i] = $p_component;
	    return $i;
	}
    }
    $p_component->set_id($n);
    $self->{$p_entity}->[$n] = $p_component;
    return $n;

}

sub delete_component {
    my ( $self, $p_entity, $p_id ) = @_;
    $self->{$p_entity}->[$p_id] = undef;
    return $p_id;
}

sub get_weapon {
    my ( $self, $p_id ) = @_;
    return $self->get_component( 'weapons', $p_id );
}

sub get_weapons {
    my ( $self ) = @_;
    return $self->get_entity( 'weapons' );
}

sub add_weapon {
    my ( $self, $p_weapon ) = @_;
    return $self->add_component( 'weapons', $p_weapon );
}

sub delete_weapon {
    my ( $self, $p_id ) = @_;
    return $self->delete_component( 'weapons', $p_id );
}

sub get_character {
    my ( $self, $p_id ) = @_;
    return $self->get_component( 'characters', $p_id );
}

sub get_characters {
    my ( $self ) = @_;
    return $self->get_entity( 'characters' );
}

sub add_character {
    my ( $self, $p_ch ) = @_;
    return $self->add_component( 'characters', $p_ch );
}

sub delete_character {
    my ( $self, $p_id ) = @_;
    return $self->delete_component( 'characters', $p_id );
}

##
# TODO: Move these to testing library
##

sub _generate_weapon {
    my ( $self, $p_args ) = @_;

    my $weapon = RPG::GameEntity::Item::Weapon->new
	(
	    'name'   => $p_args->{'name'},
	    'type'   => $p_args->{'type'},
	    'dp'     => $p_args->{'dp'},
	);

    return $weapon;
}


sub _generate_weapons {
    my ( $self, $p_count ) = @_;

    foreach my $i ( 0 .. $p_count ) {

	my $dp = ( ( 2 * int(rand($i)) ) % $p_count ) + 1;

	if ( $dp < 0 ) {
	    $dp *= -1;
	}

	my $w_properties = {
	    'name' =>  'dagger',
	    'type' =>  'edged',
	    'dp'   =>  $dp,
	};

	my $weapon = $self->_generate_weapon($w_properties);
	$self->add_weapon($weapon);
    }
}

sub _generate_character {
    my ( $self, $p_args ) = @_;

    my $character = RPG::GameEntity::Character->new
	(
	    'name' => $p_args->{'name'},
	    'hp'   => $p_args->{'hp'},
	);

    return $character;
}

sub _generate_characters {
    my ( $self, $p_count ) = @_;

    foreach my $i ( 1 .. $p_count ) {

	my $hp = ( ( 2 * int(rand($i)) ) % $p_count ) + 1;

	if ( $hp < 0 ) {
	    $hp *= -1;
	}

	my $c_properties = {
	    'name' => qq{Player.$i},
	    'hp'   => $hp,
	};

	my $character = $self->_generate_character($c_properties);
	$self->add_character($character);
    }
}

1;
