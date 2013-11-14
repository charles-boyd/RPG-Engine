package Utils::Weapon;

use warnings;
use strict;

use RPG::Entity::GameEntity::Item::Weapon;

require Exporter;
our @ISA    = qw{ Exporter };
our @EXPORT = qw{ generate_weapon generate_weapons };

sub generate_weapon {
    my ( $p_args ) = @_;

    my $weapon = RPG::Entity::GameEntity::Item::Weapon->new
	(
	    'name'   => $p_args->{'name'},
	    'attributes' =>
		{
		    'type'   => 'edged',
		    'dp'     => int(rand(8)),
		},
	);

    return $weapon;
}

sub generate_weapons {
    my ( $p_count ) = @_;

    my @weapons = ();

    foreach my $i ( 0 .. $p_count ) {
	push( @weapons, generate_weapon( { 'name' => 'dagger' } ) );
    }

    return \@weapons;
}

1;
