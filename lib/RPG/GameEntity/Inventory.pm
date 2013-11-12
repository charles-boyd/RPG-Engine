package RPG::GameEntity::Inventory;

use warnings;
use strict;

use parent qw{ RPG::GameEntity };

sub new {
    my ( $this, %params ) = @_;
    my $class = ref($this) || $this;
    my $self = $class->SUPER::new(%params);
    bless($self, $class);
    return $self;
}

sub get_items {
    my ( $self ) = @_;
    return $self->get_property('items');
}

sub add_item {
    my ( $self, $p_item ) = @_;
    push( @{ $self->get_property('items') }, $p_item );
}

1;
