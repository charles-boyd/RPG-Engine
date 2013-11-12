package RPG::MapEntity;

use warnings;
use strict;

sub new {
    my ( $class, %params ) = @_;

    my $self =
	{
	    'id'       => $params{'id'} // 0,
	    'position' =>
		{
		    'x' => $params{'position'}->{'x'} // 0,
		    'y' => $params{'position'}->{'y'} // 0
		},
	};

    bless($self,$class);
    return $self;
}

sub get_id       { return $_[0]->{'id'}; }
sub get_position { return $_[0]->{'position'}; }

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

sub set_position {
    my ( $self, $p_coordinates ) = @_;
    $self->{'position'}->{'x'} = $p_coordinates->{'x'};
    $self->{'position'}->{'y'} = $p_coordinates->{'y'};
    return $self->{'position'};
}

1;
