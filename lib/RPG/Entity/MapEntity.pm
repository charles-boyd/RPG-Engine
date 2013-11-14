package RPG::Entity::MapEntity;

use warnings;
use strict;

use Carp;

sub new {
    my ( $this, %p_args ) = @_;
    my $class = ref($this) || $this;
    return $class->SUPER::new(%p_args);
}

sub get_position { return $self->get_property('position'); }
sub get_velocity { return $self->get_property('velocity'); }

sub is_hidden { return defined($self->get_flag('hidden')); }

sub set_position {
    my ( $self, $p_coordinates ) = @_;
    my $pos = $self->get_position();

    $pos->{'x'} = $p_coordinates->{'x'};
    $pos->{'y'} = $p_coordinates->{'y'};

    return $self->{'position'};
}

sub move {
    my ( $self, $p_direction, $p_magnitude ) = @_;

    my $p_vector  = uc($p_direction);

    my $p_current = $self->get_position();

    my $p_delta   = { 'x' => 0, 'y' => 0 };

    $p_magnitude //= 1;

    if ( $p_vector eq 'UP' ) {
	$p_delta->{'y'} += $p_magnitude;
    }
    elsif ( $p_vector eq 'DOWN' ) {
	$p_delta->{'y'} -= $p_magnitude;
    }
    elsif ( $p_vector eq 'RIGHT' ) {
	$p_delta->{'x'} += $p_magnitude;
    }
    elsif ( $p_vector eq 'LEFT' ) {
	$p_delta->{'x'} -= $p_magnitude;
    }
    else {
	warn "Not a valid direction:  $p_direction";
    }

    return $self->set_position($p_delta);
}

sub move_right {
    my ( $self, $p_magnitude ) = @_;
    return $self->move( 'RIGHT', $p_magnitude );
}

sub move_left {
    my ( $self, $p_magnitude ) = @_;
    return $self->move( 'LEFT', $p_magnitude );
}

sub move_up {
    my ( $self, $p_magnitude ) = @_;
    return $self->move( 'UP', $p_magnitude );
}

sub move_down {
    my ( $self, $p_magnitude ) = @_;
    return $self->move( 'DOWN', $p_magnitude );
}


1;
