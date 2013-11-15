#!/usr/bin/env perl

use warnings;
use strict;

use RPG::Engine;

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

    my $engine = RPG::Engine->new();

    $engine->load_activity('CombatActivity', 'attacker' => $p, 'target' => $e, );

    my $activity = $engine->run();

    dd($activity);
    return 0;
}
