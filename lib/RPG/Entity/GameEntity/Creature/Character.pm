package RPG::Entity::GameEntity::Creature::Character;

use warnings;
use strict;

use parent qw{ RPG::Entity::GameEntity::Creature };

use Carp;

sub new {
    my ( $this, %p_args) = @_;
    my $class = ref($this) || $this;
    return $class->SUPER::new(%p_args);
}

sub alignment { return $_[0]->get_attribute('alignment'); }

sub get_alignment { return $_[0]->alignment(); }

sub set_alignment {
    my ( $self, $p_alignment ) = @_;
    $self->set_attribute('alignment') = $p_alignment;
}

1;
