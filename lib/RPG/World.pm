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

sub get_characters {
    my ( $self ) = @_;
    return $self->{'characters'};
}


sub generate_weapons {
    my ( $self ) = @_;

    my $short_sword = RPG::GameEntity::Item::Weapon->new( 'id' => 1, 'name' => 'shortsword', 'properties' => { 'dp' => 2, } );
    my $broad_sword = RPG::GameEntity::Item::Weapon->new( 'id' => 2, 'name' => 'broadsword', 'properties' => { 'dp' => 4, } );

    push( @{ $self->{'weapons'} }, $short_sword );
    push( @{ $self->{'weapons'} }, $broad_sword );
}

sub generate_characters {
    my ( $self, $p_count ) = @_;

    foreach my $i ( 1 .. $p_count ) {

	my $character = RPG::GameEntity::Character->new
	    (
		'id'   => $i,
		'name' => qq{player.$i},
		'hp'   => 50 + int(rand(10)),
	    );

	foreach my $weapon ( @{ $self->{'weapons'} } ) {
	    $character->add_weapon($weapon);
	}

	if ( $i % 2 == 0 ) {
	    $character->equip_weapon($self->{'weapons'}->[0]);
	} else {
	    $character->equip_weapon($self->{'weapons'}->[1]);
	}
	push( @{ $self->{'characters'} }, $character );
    }
}

1;
