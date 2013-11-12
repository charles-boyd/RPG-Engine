package RPG::GameEntity::Item;

use warnings;
use strict;

use parent qw{ RPG::GameEntity };

sub new {
    my ( $this, %params ) = @_;

    my $class = ref($this) || $this;
    my $self = $class->SUPER::new(%params);
    bless($self,$class);
    return $self;
}

sub get_value { return $_[0]->get_property('value'); }

sub set_value {
    my ( $self, $p_value ) = @_;
    return $self->set_value($p_value);
}

1;
