package RPG::Engine;

use warnings;
use strict;

use Carp;

use RPG::World;
use RPG::Engine::Activity::CombatActivity;

sub new {
    my ( $class, %p_args ) = @_;

    my $self = { };

    bless($self,$class);

    my $world = $p_args{'world'} // RPG::World->new();
    $self->set_world($world);

    return $self;
}

sub activity { return $_[0]->{'ACTIVITY'}; }
sub world    { return $_[0]->{'WORLD'};    }

sub set_world {
    my ( $self, $p_world ) = @_;
    $self->{'WORLD'} = $p_world;
}

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

	$self->world()->update();

    }

    return $self->activity();
}

1;
