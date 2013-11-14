package RPG::Engine::Activity;

use warnings;
use strict;

#use RPG::Engine::Activity::DungeonActivity;
#use RPG::Engine::Activity::DialogueActivity;

use RPG::Engine::Activity::CombatActivity;

sub new {
    my ( $class, %p_args ) = @_;
    my $self = { };
    bless($self,$class);
    return $self->on_create();
}

sub state { return $_[0]->{'state'}; }

sub get_state { return $_[0]->state(); }

sub set_state {
    my ( $self, $p_state ) = @_;
    $self->{'state'} = $p_state;
}

sub on_create {
    my ( $self ) = @_;
    $self->set_state('RUNNING');
    return $self;
}

sub on_pause {
    my ( $self ) = @_;
    $self->set_state('PAUSED');
    return $self;
}

sub on_interrupt {
    my ( $self ) = @_;
    $self->set_state('INTERRUPT');
    return $self;
}

sub on_resume {
    my ( $self ) = @_;
    $self->set_state('RUNNING');
    return $self;
}

sub on_destroy {
    my ( $self ) = @_;
    $self->set_state('FINISHED');
    return $self;
}

1;
