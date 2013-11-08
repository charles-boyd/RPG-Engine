package RPG::Character;

use warnings;
use strict;

use RPG::Inventory;

sub new {
    my ( $class, %params ) = @_;

    my $self =
	{
	    'id'        => $params{'id'}        // 0,
	    'name'      => $params{'name'}      // 'MISSINGNO',
	    'hp'        => $params{'hp'}        // 100,
	    'status'    => $params{'status'}    // 'OK',
	    'weapon'    => $params{'weapon'}    // undef,
	    'inventory' => $params{'inventory'} // RPG::Inventory->new(),
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
    my ( $self, $w_name ) = @_;

    my $weapon = $self->{'inventory'}->get_weapon($w_name);

    if ( ! defined($w_name) ) {
	warn "weapon $w_name is not in the inventory.";
	return undef;
    } else {
	$self->{'weapon'} = $weapon;
	$weapon->set_status( 'EQUIPPED' );
    }
    return $w_name;
}

sub add_weapon {
    my ( $self, $weapon ) = @_;
    return $self->{'inventory'}->add_weapon($weapon);
}

sub take_damage {
    my ( $self, $damage ) = @_;

    my $remaining_hp = $self->{'hp'} - $damage;

    if ( $remaining_hp <= 0 ) {
	$self->{'hp'} = 0;
	$self->{'status'} = 'DEAD';
    }

    $self->{'hp'} = $remaining_hp;
    return $damage;
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
