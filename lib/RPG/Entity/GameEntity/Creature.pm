package RPG::Entity::GameEntity::Creature;

use warnings;
use strict;

use parent qw{ RPG::Entity::GameEntity };

use Carp;
use RPG::Entity::GameEntity::Inventory;

sub new {
    my ( $this, %p_args) = @_;
    my $class = ref($this) || $this;
    my $self = $class->SUPER::new(%p_args);

    if ( ! $self->has_property('inventory') ) {
	my $inventory = RPG::Entity::GameEntity::Inventory->new();
	$self->set_property('inventory', $inventory);
    }

    if ( ! $self->has_attribute('hp') ) {
	$self->set_attribute('hp',10);
    }

    if ( ! $self->has_attribute('health') ) {
	$self->set_attribute('health', $self->hp());
    }

    return $self;
}

sub hp           { return $_[0]->get_attribute('hp');           }
sub health       { return $_[0]->get_attribute('health');       }
sub level        { return $_[0]->get_attribute('level');        }
sub species      { return $_[0]->get_attribute('species');      }
sub class        { return $_[0]->get_attribute('class');        }
sub strength     { return $_[0]->get_attribute('strength');     }
sub dexterity    { return $_[0]->get_attribute('dexterity');    }
sub constitution { return $_[0]->get_attribute('constitution'); }
sub wisdom       { return $_[0]->get_attribute('wisdom');       }
sub intelligence { return $_[0]->get_attribute('intelligence'); }
sub charisma     { return $_[0]->get_attribute('charisma');     }

sub weapon       { return $_[0]->get_property('weapon');    }
sub armor        { return $_[0]->get_property('armor');     }
sub inventory    { return $_[0]->get_property('inventory'); }

sub get_hp      { return $_[0]->hp();     }
sub get_level   { return $_[0]->level();  }
sub get_species { return $_[0]->level();  }
sub get_class   { return $_[0]->class();  }
sub get_health  { return $_[0]->health(); }
sub get_weapon  { return $_[0]->weapon(); }
sub get_armor   { return $_[0]->armor();  }

sub set_hp {
    my ( $self, $p_hp ) = @_;
    $self->set_attribute( 'hp', $p_hp );
}

sub set_health {
    my ( $self, $p_health ) = @_;
    $self->set_attribute( 'health', $p_health );
}

sub equip_item {
    my ( $self, $p_key, $p_item ) = @_;
    $self->set_property($p_key, $p_item);
}

sub equip_weapon {
    my ( $self, $p_weapon ) = @_;
    $self->equip_item( 'weapon', $p_weapon );
}

sub equip_armor {
    my ( $self, $p_armor ) = @_;
    $self->equip_item( 'armor', $p_armor );
}

sub attack {
    my ( $self, $p_target ) = @_;
    return $p_target->take_damage( $self->weapon()->dp() );
}

sub take_damage {
    my ( $self, $p_damage ) = @_;

    my $remaining_hp = $self->health() - $p_damage;

    if ( $remaining_hp <= 0 ) {
	$self->set_health(0);
	$self->set_status('DEAD');
    } else {
	$self->set_health($remaining_hp);
    }

    return $p_damage;
}

1;
