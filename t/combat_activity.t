#!/usr/bin/env perl

use warnings;
use strict;

use RPG::Engine::Activity::CombatActivity;

use Utils::Character qw{ generate_character };
use Utils::Weapon qw{ generate_weapon };

my $w1 = generate_weapon( { 'name' => 'dagger', } );
my $w2 = generate_weapon( { 'name' => 'knife',  } );

my $p1 = generate_character( { 'name' => 'TestCharacter', } );
$p1->inventory()->add_item($w1);
$p1->equip_weapon($w1);

my $p2 = generate_character( { 'name' => 'TestTarget', } );
$p2->inventory()->add_item($w2);
$p2->equip_weapon($w2);

my $combat = RPG::Engine::Activity::CombatActivity->new( 'attacker' => $p1, 'target' => $p2, );
$combat->run();
use Data::Dumper;
print Dumper $combat->winner();

