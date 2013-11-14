package RPG::Engine::Activity::CombatActivity;

use warnings;
use strict;

use parent qw{ RPG::Engine::Activity };

sub new {
    my ( $this, %p_args ) = @_;
    my $class = ref($this) || $this;
    my $self  = $class->SUPER::new(%p_args);
    $self->{'attacker'}   = $p_args{'attacker'};
    $self->{'target'}     = $p_args{'target'};
    $self->{'turn_count'} = 0;
    return $self;
}

sub attacker   { return $_[0]->{'attacker'};  }
sub target     { return $_[0]->{'target'}; }
sub winner     { return $_[0]->{'winner'};         }
sub turn_count { return $_[0]->{'turn_count'};     }

sub set_attacker {
    my ( $self, $p_attacker ) = @_;
    $self->{'attacker'} = $p_attacker;
    return 1;
}

sub set_target {
    my ( $self, $p_target ) = @_;
    $self->{'target'} = $p_target;
    return 1;
}

sub run {
    my ( $self ) = @_;

    while ( ! defined ( $self->winner() ) ) {
	$self->{'turn_counter'} += 1;
	$self->process_turn();
    }

    return $self->on_destroy();
}

sub process_turn {
    my ( $self ) = @_;

    my ( $attacker, $target ) = ( $self->attacker(), $self->target() );

    my $damage = $attacker->attack( $target );

    # $target->update();
    # $attacker->update();

    if ( $target->health() > 0 ) {
	$self->set_attacker($target);
	$self->set_target($attacker);
	return 0;
    }

    $self->{'winner'} = $attacker
	if ( $attacker->status() ne 'DEAD' );

    return 1;
}

1;

