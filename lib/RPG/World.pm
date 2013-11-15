package RPG::World;

use warnings;
use strict;

sub new {
    my ( $class, %p_args ) = @_;

    my $self =
	{
	    'hero'      => $p_args{'hero'}                // undef,
	    'entities'  =>
		{
		    'creatures' => $p_args{'creatures'}  // undef,
		    'items'     => $p_args{'items'}      // undef,
		},
	};

    bless($self,$class);
    return $self;
}

sub hero      { return $_[0]->{'hero'}; }
sub creatures { return $_[0]->{'entities'}->{'creatures'}; }
sub items     { return $_[0]->{'entities'}->{'items'}; }

sub add_entity_to_table {
    my ( $self, $p_table_key, $p_entity ) = @_;

    if ( exists($self->{'entities'}->{$p_table_key}) ) {
	my $entity_key = $p_entity->id();
	$self->{'entities'}->{$p_table_key}->{$entity_key} = $p_entity;
	return $entity_key;
    }

    return 0;
}

sub add_creature {
    my ( $self, $p_creature ) = @_;

    # sanity check

    return $self->add_entity_to_table( 'creatures', $p_creature);
}


sub add_item {
    my ( $self, $p_item ) = @_;

    # sanity check

    return $self->add_entity_to_table( 'items', $p_item);
}

sub update {
    my ( $self ) = @_;

    foreach my $k ( keys %{ $self->creatures() } ) {
	$self->{'entities'}->{'creatures'}->{$k}->update()
	    if ( defined($self->{'entities'}->{'creatures'}->{$k}) );
    }

    foreach my $i ( keys %{ $self->items() } ) {
	$self->{'entities'}->{'items'}->{$i}->update()
	    if ( defined($self->{'entities'}->{'items'}->{$i}) );
    }

    $self->hero()->update();

    return $self;

}

1;
