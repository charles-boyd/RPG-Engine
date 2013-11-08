package RPG::Inventory;

use warnings;
use strict;

sub new {
    my ( $class, %params ) = @_;

    my $self =
	{
	    'id'    => $params{'id'},
	    'items' =>
		{
		    'weapons' => $params{'weapons'} // { },
		},
	};
    bless($self, $class);
    return $self;
}

sub add_weapon {
    my ( $self, $weapon ) = @_;
    my $w_key = $weapon->get_name();
    $self->{'items'}->{'weapons'}->{$w_key} = $weapon;
    return $w_key;
}

sub get_weapon {
    my ( $self, $w_key ) = @_;
    return $self->{'items'}->{'weapons'}->{$w_key};
}

1;
