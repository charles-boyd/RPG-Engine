#!/usr/bin/env perl

use warnings;
use strict;

use RPG::Entity::GameEntity::Creature;

use Utils::Character qw{ generate_character };
use Utils::Weapon qw{ generate_weapon };

use Data::Dumper;

my %creature_args =
    (
	'name'       => 'TestCreature',
	'status'     => 'OK',
	'attributes' =>
	    {
		'hp'       => 50,
		'level'    => 2,
		'species'  => q{human},
		'class'    => q{thief},
		'strength'     => 4,
		'dexterity'    => 9,
		'constitution' => 5,
		'wisdom'       => 7,
		'intelligence' => 10,
		'charisma'     => 4,
	    },
    );

my $creature  = RPG::Entity::GameEntity::Creature->new(%creature_args);
print Dumper $creature;

my $weapon = generate_weapon();
print Dumper $weapon;

my $character = generate_character( { 'name' => 'TestCharacter' } );
$character->inventory()->add_item($weapon);
$character->equip_weapon($weapon);

print Dumper $character;

print "initial health: ", $creature->health(),"\n";
while ( $creature->health() > 0 ) {
    my $damage = $character->attack($creature);
    print "damage: $damage","\n";
    print "health remaining: ", $creature->health(),"\n";
}


