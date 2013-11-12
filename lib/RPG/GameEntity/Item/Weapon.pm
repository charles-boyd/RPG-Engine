package RPG::GameEntity::Item::Weapon;

use warnings;
use strict;

use parent qw{ RPG::GameEntity::Item };

sub new {
    my ( $this, %params ) = @_;
    my $class = ref($this) || $this;
    my $self  = $class->SUPER::new(%params);
    bless($self,$class);
    return $self;
}

sub get_dp { return $_[0]->get_property('dp'); }

sub set_dp {
    my ( $self, $dp ) = @_;
    $self->set_property('dp',$dp);
}



1;
