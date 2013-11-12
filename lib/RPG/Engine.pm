package RPG::Engine;

use warnings;
use strict;

use RPG::World;

sub new {
    my ( $class, %params ) = @_;

    my $self =
	{
	    'WORLD'   => RPG::World->new(),
	    'turn'    => 0,
	};

    bless($self,$class);
    return $self;
}

sub load {
    my ( $self ) = @_;
    $self->{'WORLD'}->generate_weapons();
    $self->{'WORLD'}->generate_characters(5);
}

sub run {
    my ( $self ) = @_;

    my @characters = @{ $self->{'WORLD'}->get_characters() };

    while ( my $n = scalar(@characters) ) {

	if ( $n == 1 ) {
	    print $characters[0]->get_name() . " has won!","\n";
	    return 0;
	}

	my $k = shift(@characters);

	my $r = int(rand($n - 1));
	my $target = $characters[$r];

	if ( $k->get_status() eq 'DEAD' ) {
	    next;
	}
	elsif ( $target->get_status() eq 'DEAD' ) {
	    unshift( @characters, $k );
	    next;
	}
	elsif ( $target->get_id() == $k->get_id() ) {
	    unshift( @characters, $k );
	    next;
	}
	else {
	    push( @characters, $k );

	    my $weapon = $k->get_weapon();
	    my $damage = $k->perform_action( 'attack', $target, $weapon );

	    print $k->get_name()
		  . " attacks " . $target->get_name()
		  . " with "    . $weapon->get_name()
                  . " for "     . $damage
		  . " dp.","\n";

	    print $target->get_name() . " has " . $target->get_hp() . " hp remaining.","\n";

	    if ( $target->get_status() eq 'DEAD' ) {
		print '*'x2 . $target->get_name() . " has died!" . '*'x2 , "\n";
	    }
	}
	print '-'x40,"\n"
    }
    return 0;
}

1;
