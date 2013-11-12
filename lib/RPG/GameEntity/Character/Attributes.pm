package RPG::GameEntity::Character::Attributes;

use warnings;
use strict;

sub new {
    my ( $class, %params ) = @_;

    my $self = {};
    bless($self,$class);
    return $self;
}

1;

