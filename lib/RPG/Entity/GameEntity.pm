package RPG::Entity::GameEntity;

use warnings;
use strict;

use parent qw{ RPG::Entity };

use Carp;

sub new {
    my ( $this, %p_args ) = @_;

    my $class = ref($this) || $this;
    my $self = $class->SUPER::new(%p_args);

    return $self;
}

1;
