#!/usr/bin/env perl

use warnings;
use strict;

use RPG::Entity::GameEntity::Creature;
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

my $creature = RPG::Entity::GameEntity::Creature->new(%creature_args);
print Dumper $creature;
