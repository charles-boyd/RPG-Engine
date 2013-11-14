package RPG::Entity::GameEntity::Inventory;

use warnings;
use strict;

use parent qw{ RPG::Entity::GameEntity };

sub new {
    my ( $this, %params ) = @_;
    my $class = ref($this) || $this;
    my $self = $class->SUPER::new(%params);

    $self->set_property( 'items', [] )
	if( ! $self->has_property('items') );

    return $self;
}

sub items { return $_[0]->get_property('items'); }

sub get_items { return $_[0]->items(); }

sub add_item {
    my ( $self, $p_item ) = @_;
    push( @{ $self->get_property('items') }, $p_item );
}

sub get_item_by_id {
    my ( $self, $p_id ) = @_;

    foreach my $item ( @{ $self->items() } ) {
	if ( $item->id() eq $p_id ) {
	    return $item;
	}
    }

    return 0;
}

sub get_item_by_name {
    my ( $self, $p_name ) = @_;

    foreach my $item ( @{ $self->items() } ) {
	if ( $item->name() eq $p_name ) {
	    return $item;
	}
    }

    return 0;
}



1;
