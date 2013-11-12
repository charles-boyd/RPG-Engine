package RPG::GameEntity::Character;

use warnings;
use strict;

use RPG::GameEntity::Inventory;

sub new {
    my ( $class, %params ) = @_;

    my $self =
	{
	    'id'        => $params{'id'}        // 0,
	    'name'      => $params{'name'}      // 'MISSINGNO',
	    'hp'        => $params{'hp'}        // 100,
	    'status'    => $params{'status'}    // 'OK',
	    'weapon'    => $params{'weapon'}    // undef,
	    'inventory' => $params{'inventory'} // [],
	    'actions'   =>
		{
		    'attack' =>
			sub {
			    my ( $target, $weapon ) = @_;
			    return $target->take_damage( $weapon->get_dp() );
			},
		},
	};

    bless($self,$class);
    return $self;
}

sub get_id        { return $_[0]->{'id'}; }
sub get_name      { return $_[0]->{'name'}; }
sub get_hp        { return $_[0]->{'hp'}; }
sub get_status    { return $_[0]->{'status'}; }
sub get_inventory { return $_[0]->{'inventory'}; }
sub get_weapon    { return $_[0]->{'weapon'}; }

sub equip_weapon {
    my ( $self, $p_weapon ) = @_;
    $self->{'weapon'} = $p_weapon;
    $p_weapon->set_status( 'EQUIPPED' );
}

sub add_weapon {
    my ( $self, $p_weapon ) = @_;
    push( @{ $self->{'inventory'} }, $p_weapon );
}

sub take_damage {
    my ( $self, $p_damage ) = @_;

    my $remaining_hp = $self->{'hp'} - $p_damage;

    if ( $remaining_hp <= 0 ) {
	$self->{'hp'} = 0;
	$self->{'status'} = 'DEAD';
    } else {
	$self->{'hp'} = $remaining_hp;
    }

    return $p_damage;
}

sub perform_action {
    my ( $self, $action, @args ) = @_;

    if ( $self->get_status() eq 'DEAD' ) {
	warn "cannot perform $action: " . $self->get_name() . ' is dead.';
	return 0;
    }

    return $self->{'actions'}->{$action}->(@args);
}

1;
