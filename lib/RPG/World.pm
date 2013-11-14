package RPG::World;

use warnings;
use strict;

use RPG::GameEntity::Character;
use RPG::GameEntity::Item::Weapon;

use Utils::Character qw{ generate_characters };
use Utils::Weapon    qw{ generate_weapons };

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

1;
