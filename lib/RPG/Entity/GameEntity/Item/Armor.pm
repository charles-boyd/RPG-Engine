package RPG::Entity::GameEntity::Item::Armor;

use warnings;
use strict;

use parent qw{ RPG::Entity::GameEntity::Item };

sub new {
    my ( $this, %p_args ) = @_;
    my $class = ref($this) || $this;
    my $self = $class->SUPER::new(%p_args);

    $self->set_attribute('equipable', 1);
}

sub bp   { return $_[0]->get_attribute('bp'); }
sub type { return $_[0]->get_attribute('type'); }

sub get_bp   { return $_[0]->bp(); }
sub get_type { return $_[0]->type(); }

sub set_bp {
    my ( $self, $p_dp ) = @_;
    $self->set_attribute('bp', $p_dp);
}

sub set_type {
    my ( $self, $p_type ) = @_;
    $self->set_attribute('type', $p_type);
}

1;
