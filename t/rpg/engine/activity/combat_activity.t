#!/usr/bin/env perl

use warnings;
use strict;

use RPG::Engine::Activity::CombatActivity;

use Utils::Character qw{ generate_hero generate_character };
use Utils::Weapon qw{ generate_weapon };

use Data::Dump::Color;

exit(main());

sub main {

    my $w1 = generate_weapon( { 'name' => 'dagger', } );
    my $w2 = generate_weapon( { 'name' => 'sword', } );

    my $p = generate_hero( { 'name' => 'TestHero', } );

    $p->inventory()->add_item($w2);
    $p->equip_weapon($w2);

    my $e1 = generate_character( { 'name' => 'TestEnemy-1', } );
    my $e2 = generate_character( { 'name' => 'TestEnemy-2', } );

    foreach my $e ( ( $e1, $e2 ) ) {
	$e->inventory()->add_item($w1);
	$e->equip_weapon($w1);
    }

    my $r1 = run_combat($p, $e1);

    dd($r1);

    my $r2 = run_combat($r1,$e2);

    dd($r2);

    return 0;
}

sub run_combat {
    my ( $p, $e ) = @_;

    my $combat = RPG::Engine::Activity::CombatActivity->new( 'attacker' => $p, 'target' => $e, );

    $combat->run();

    return $combat->winner();
}
