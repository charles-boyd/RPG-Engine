package Utils::Character;

use warnings;
use strict;

use RPG::Entity::GameEntity::Creature::Character;

require Exporter;
our @ISA    = qw{ Exporter };
our @EXPORT = qw{ generate_hero generate_character generate_characters };

sub generate_hero {
    my ( $p_args ) = @_;
    my $character = generate_character($p_args);
    $character->set_property('is_hero','1');
    return $character;
}

sub generate_character {
    my ( $p_args ) = @_;

    my $character = RPG::Entity::GameEntity::Creature::Character->new
	(
	    'name'   => $p_args->{'name'},
	    'status' => 'OK',
	    'attributes' =>
		{
		    'hp'           => int(rand(20)) + 10,
		    'level'        => int(rand(20)),
		    'species'      => q{human},
		    'class'        => q{thief},
		    'strength'     => int(rand(16)),
		    'dexterity'    => int(rand(16)),
		    'constitution' => int(rand(16)),
		    'wisdom'       => int(rand(16)),
		    'intelligence' => int(rand(16)),
		    'charisma'     => int(rand(16)),
		},
	);

    return $character;
}

sub generate_characters {
    my ( $p_count ) = @_;

    my @characters = ();

    foreach my $i ( 1 .. $p_count ) {
	push( @characters, generate_character( { 'name' => qq{c.$i}, } ) );
    }

    return \@characters;
}

1;
