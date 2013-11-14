package RPG::Engine;

use warnings;
use strict;

use RPG::World;

sub new {
    my ( $class, %params ) = @_;

    my $self =
	{
	    'WORLD' => RPG::World->new(),
	    'mode'  => 'COMBAT',
	};

    bless($self,$class);


    ## TODO: Move this to test code
    $self->{'WORLD'}->_generate_weapons(5);
    $self->{'WORLD'}->_generate_characters(5);

    $self->{'player'} = $self->{'WORLD'}->get_character(0);
    return $self;
}

sub get_mode  { return $_[0]->{'mode'}; }
sub get_world { return $_[0]->{'WORLD'}; }


sub set_mode {
    my ( $self, $p_mode ) = @_;
    $self->{'mode'} = $p_mode;
}


sub run {
    my ( $self ) = @_;

    my $player  = $self->{'player'};

    while( my $mode = $self->get_mode() ) {

	if ( $mode eq 'COMBAT' ) {

	    # TODO: Make this more generic by reading from global state
	    my @enemies   = ();
	    foreach my $e ( map { $self->get_world()->get_character($_) } ( 1 .. (scalar(@{ $self->get_world()->get_characters() }) - 1) ) ) {
		push( @enemies, $e )
		    if ( defined($e) && $e->get_status() ne 'DEAD' );
	    }

	    $self->combat( $player, @enemies );
	}
	elsif ( $mode eq 'GAME_OVER' ) {
	    print "GAME OVER";
	    return 0;
	} else {
	    die "error - game exited without game_over";
	    return 1;
	}
    }
    warn "escaped from main loop";
    return -1;
}

sub combat {
    my ( $self, @enemies ) = @_;

    my $n = scalar(@enemies);
    my $rand = int(rand($n - 1));

    my $player = $self->{'player'};

    if ( $n == 0 ) {
	print 'SUCCESS: ' . $player->get_name() . " has vaniqushed all $n enemies!","\n";
	$self->set_mode('GAME_OVER');
    } else {
	my $target = $enemies[$rand];
	my $weapon = $player->get_weapon();
	my $damage = $player->attack($target);

	    print $player->get_name()
		  . " attacks " . $target->get_name()
		  . " with "    . $weapon->get_name()
                  . " for "     . $damage
		  . " dp.","\n";

	    print $target->get_name() . " has " . $target->get_health() . " hp remaining.","\n";

	    if ( $target->get_status() eq 'DEAD' ) {
		print '*'x2 . $target->get_name() . " has died!" . '*'x2 , "\n";
		$self->{'WORLD'}->delete_character($target->get_id());
	    }
	print '-'x40,"\n";
    }
    $self->set_mode('COMBAT');
}

1;
