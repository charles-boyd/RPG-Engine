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

    return $self;
}

sub attacker   { return $_[0]->{'attacker'}; }
sub target     { return $_[0]->{'target'};   }
sub winner     { return $_[0]->{'winner'};   }


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

sub set_winner {
    my ( $self, $p_winner ) = @_;
    $self->{'winner'} = $p_winner;
    return 1;
}

sub process {
    my ( $self, $p_data ) = @_;
    print $p_data,"\n";
}

sub tick {
    my ( $self ) = @_;

    my @status = ();

    my ( $attacker, $target ) = ( $self->attacker(), $self->target() );

    my $damage = $attacker->attack( $target );

    push( @status, $attacker->name() . ' attacks ' . $target->name(). " for $damage dp.");

    if ( $target->health() > 0 ) {
	$self->set_attacker($target);
	$self->set_target($attacker);
	push( @status, $target->get_name() . ' has ' . $target->health() . ' hp remaining.');
    }

    my $update = join( "\n", @status );
    $self->update_status($update);

    if ( $attacker->status() ne 'DEAD' && $target->status() eq 'DEAD' ) {
	$self->set_winner($attacker);
	$self->on_complete();
	return 0;
    }

    $self->SUPER::tick();
    return $self->status();
}

1;

