package RPG::Engine;

use warnings;
use strict;

use Carp;

use RPG::Engine::Activity::CombatActivity;
use Data::Dump::Color;

sub new {
    my ( $class, %p_args ) = @_;

    my $self = { };

    bless($self,$class);
    return $self;
}

sub activity { return $_[0]->{'ACTIVITY'}; }

sub set_activity {
    my ( $self, $p_activity ) = @_;
    $self->{'ACTIVITY'} = $p_activity;
    return 1;
}

sub load_activity {
    my ( $self, $p_class, %p_args ) = @_;
    my $class_name = q{RPG::Engine::Activity::} . qq{$p_class};
    my $activity = $class_name->new(%p_args);
    $self->set_activity($activity);
}

sub run {
    my ( $self ) = @_;

    while ( my $status = $self->activity()->tick() ) {

	my $state = $self->activity()->state();

	if ( $state eq 'COMPLETE' || $state eq 'INTERRUPT' || $state eq 'PAUSED' ) {
	    last;
	}

	if ( $state eq 'BLOCKING' ) {
	    $self->activity()->message('A');
	    next;
	}
    }

    return $self->activity();
}

1;
