#!/usr/bin/env perl

use warnings;
use strict;

use lib '../lib';

use RPG::Character;
use RPG::Item::Weapon;

exit(main());

sub main {

    my @characters = generate_characters(5);

    while ( my $n = scalar(@characters) ) {

	if ( $n == 1 ) {
	    print $characters[0]->get_name() . " has won!","\n";
	    return 0;
	}


	my $k = shift(@characters);

	my $r = int(rand($n - 1));
	my $target = $characters[$r];

	if ( $k->get_status() eq 'DEAD' ) {
	    next;
	}
	elsif ( $target->get_status() eq 'DEAD' ) {
	    unshift( @characters, $k );
	    next;
	}
	elsif ( $target->get_id() == $k->get_id() ) {
	    unshift( @characters, $k );
	    next;
	}
	else {
	    push( @characters, $k );

	    my $weapon = $k->get_weapon();
	    my $damage = $k->perform_action( 'attack', $target, $weapon );

	    print $k->get_name()
		  . " attacks " . $target->get_name()
		  . " with "    . $weapon->get_name()
                  . " for "     . $damage
		  . " dp.","\n";

	    print $target->get_name() . " has " . $target->get_hp() . " hp remaining.","\n";

	    if ( $target->get_status() eq 'DEAD' ) {
		print '*'x2 . $target->get_name() . " has died!" . '*'x2 , "\n";
	    }
	}
	print '-'x40,"\n"
    }
}



sub generate_characters {
    my $n = shift;

    my $short_sword = RPG::Item::Weapon->new( 'id' => 1, 'name' => 'shortsword', 'properties' => { 'dp' => 2, } );
    my $broad_sword = RPG::Item::Weapon->new( 'id' => 1, 'name' => 'broadsword', 'properties' => { 'dp' => 4, } );

    my @c = ();
    foreach my $i ( 1 .. $n ) {
	my $character = RPG::Character->new
	    (
		'id'   => $i,
		'name' => qq{player.$i},
		'hp'   => 10,
	    );
	$character->add_weapon($short_sword);
	$character->add_weapon($broad_sword);
	if ( $i % 2 == 0 ) {
	    $character->equip_weapon($short_sword->get_name());
	} else {
	    $character->equip_weapon($broad_sword->get_name());
	}
	push( @c, $character );
    }
    return @c;
}
