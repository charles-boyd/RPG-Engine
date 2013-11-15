#!/usr/bin/env perl

use warnings;
use strict;

use RPG::Engine;
use RPG::World;

use Utils::Character qw{ generate_hero generate_character };
use Utils::Weapon qw{ generate_weapon };

use Data::Dump::Color;

exit(main());

sub main {

    my $w1 = generate_weapon( { 'name' => 'dagger', } );
    my $w2 = generate_weapon( { 'name' => 'sword', } );

    my $p = generate_hero( { 'name' => 'TestHero', } );

    $p->inventory()->add_item($w1);
    $p->equip_weapon($w1);

    my $e = generate_character( { 'name' => 'TestEnemy', } );

    $e->inventory()->add_item($w2);
    $e->equip_weapon($w2);

    my $world  = RPG::World->new( 'hero' => $p );
    $world->add_item($w1);
    $world->add_item($w2);
    $world->add_creature($e);

    my $engine = RPG::Engine->new( 'world' => $world );

    $engine->load_activity('CombatActivity', 'attacker' => $p, 'target' => $e, );

    my $activity = $engine->run();

    foreach ( @{ $activity->status() } ) {
	print $_,"\n";
	print '-'x20,"\n";
    }

    print 'winner: ' . $activity->winner()->name(),"\n";

    dd($activity->winner());

    return 0;
}
