package RPG::Entity::GameEntity::Item;

use warnings;
use strict;

use parent qw{ RPG::Entity::GameEntity };

sub new {
    my ( $this, %params ) = @_;
    my $class = ref($this) || $this;
    return $class->SUPER::new(%params);
}

sub is_equipable { return $_[0]->has_attribute('equipable'); }
sub is_equipped  { return $_[0]->status() eq 'EQUIPPED'; }

1;
