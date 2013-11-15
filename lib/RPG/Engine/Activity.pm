package RPG::Engine::Activity;

use warnings;
use strict;

use Carp;

sub new {
    my ( $class, %p_args ) = @_;

    my $state_table =
	[
	    'IDLE', 'READY', 'PROCESSING',
	    'PAUSE', 'RESUME', 'BLOCKING',
	    'COMPLETE', 'INTERRUPT', 'PANIC'
	];

    my $terminal_states = 
	[ 'COMPLETE', 'INTERRUPT', 'PANIC' ];

    my $self =
	{
	    'state_table'        => $state_table,
	    'terminal_states'          => $terminal_states,
	    'state'              => $p_args{'state'} // 'IDLE',
	    'turn_count'         => $p_args{'turn_count'} // 0,
	    'messages'           => [ ],
	    'status'             => [ ],
	};

    bless($self,$class);

    $self->{'event_table'} =
	{
	    'on_create'    =>
		sub
		    {
			my $closure_self = shift;
			$closure_self->set_state('READY');
		    },
	    'on_pause'     =>
		sub
		    {
			my $closure_self = shift;
			$closure_self->set_state('PAUSE');
		    },
	    'on_block'    =>
		sub
		    {
			my $closure_self = shift;
			$closure_self->set_state('BLOCKING');
		    },
	    'on_resume'    =>
		sub
		    {
			my $closure_self = shift;
			$closure_self->set_state('READY');
		    },
	    'on_message'    =>
		sub
		    {
			my $closure_self = shift;
			$closure_self->consume();
			$closure_self->set_state('PROCESSING');
		    },
	    'on_consume'    =>
		sub
		    {
			my $closure_self = shift;
			$closure_self->set_state('READY');
		    },
	    'on_complete'  =>
		sub
		    {
			my $closure_self = shift;
			$closure_self->set_state('COMPLETE');
		    },
	    'on_interrupt' =>
		sub
		    {
			my $closure_self = shift;
			my $reason       = shift // 'User interrupt';
			$closure_self->set_state('INTERRUPT');
			warn(qq{[PANIC]: $reason});
		    },
	    'on_panic'     =>
		sub
		    {
			my $closure_self = shift;
			my $error        = shift // 'Uncaught exception';
			$closure_self->set_state('PANIC');
			croak(qq{[PANIC]: $error});
		    },
	};

    return $self->on_create();
}

sub state           { return $_[0]->{'state'};           }
sub terminal_states { return $_[0]->{'terminal_states'}; }
sub state_table     { return $_[0]->{'state_table'};     }
sub turn_count      { return $_[0]->{'turn_count'};      }
sub messages        { return $_[0]->{'messages'};        }
sub status          { return $_[0]->{'status'};   }

sub is_valid_state {
    my ( $self, $p_state ) = @_;

    if ( scalar(grep { /$p_state/ } @{ $self->state_table() }) > 0 ) {
	return 1;
    }

    return 0;
}

sub is_terminal_state {
    my ( $self, $p_state ) = @_;

    if ( scalar(grep { /$p_state/ } @{ $self->terminal_states() }) > 0 ) {
	return 1;
    }

    return 0;
}

sub set_state {
    my ( $self, $p_state ) = @_;

    if ( ! $self->is_valid_state($p_state) ) {
	$self->panic("Cannot transition to unknown state: $p_state");
	return 0;
    }

    if ( $self->is_terminal_state( $self->state() ) ) {
	$self->panic("Cannot transition from terminal state");
	return 0;
    }

    $self->{'state'} = $p_state;
    return 1;
}

sub update_status {
    my ( $self, $p_status ) = @_;
    push( @{ $self->status() }, $p_status );
}

sub tick {
    my ( $self ) = @_;

    $self->{'turn_count'}++;

    return $self;
}

sub consume {
    my ( $self ) = @_;

    my $msg = pop( @{ $self->messages() } );

    if ( ! $self->process($msg) ) {
	$self->croak("Failed to process message: $msg");
	return 0;
    }

    return $self->on_consume();
}

sub pause {
    my ( $self ) = @_;

    # serialize persistent data to file/database and exit loop

    return $self->on_pause();
}

sub resume {
    my ( $self ) = @_;

    # restore data from file/database and resume processing

    return $self->on_resume();
}

sub block {
    my ( $self, $p_reason ) = @_;

    print "blocking: $p_reason","\n";

    return $self->on_block();
}

sub message {
    my ( $self, $p_msg ) = @_;
    push( @{ $self->messages() }, $p_msg );
    return $self->on_message();
}

sub complete {
    my ( $self ) = @_;

    # sanity check data and restore control back to caller

    return $self->on_complete();
}

sub interrupt {
    my ( $self, $p_reason ) = @_;

    # clean up and restore control back to caller

    return $self->on_interrupt($p_reason);
}

sub panic {
    my ( $self, $p_reason ) = @_;

    # exit immediately, do not attempt to clean up or serialize

    return $self->on_panic($p_reason);
}

sub register_event_listener {
    my ( $self, $p_event, $p_listener ) = @_;
    $self->{'event_table'}->{$p_event} = $p_listener;
    return $p_event;
}

sub on_event {
    my ( $self, $p_event, @p_args ) = @_;

    if ( defined($self->{'event_table'}->{$p_event}) ) {
	$self->{'event_table'}->{$p_event}->($self, @p_args);
    }

    if ( $self->is_terminal_state( $self->state() ) ) {
	return 0;
    }

    return $self;
}

sub on_create    { return shift->on_event( 'on_create',    @_ ); }
sub on_pause     { return shift->on_event( 'on_pause',     @_ ); }
sub on_resume    { return shift->on_event( 'on_resume',    @_ ); }
sub on_block     { return shift->on_event( 'on_block',     @_ ); }
sub on_message   { return shift->on_event( 'on_message',   @_ ); }
sub on_consume   { return shift->on_event( 'on_consume',   @_ ); }
sub on_complete  { return shift->on_event( 'on_destroy',   @_ ); }
sub on_interrupt { return shift->on_event( 'on_interrupt', @_ ); }
sub on_panic     { return shift->on_event( 'on_panic',     @_ ); }

1;
