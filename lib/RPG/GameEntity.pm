package RPG::GameEntity;

use warnings;
use strict;

sub new {
    my ( $class, %params ) = @_;

    my $self =
	{
	    'id'         => $params{'id'}         // 0,
	    'name'       => $params{'name'}       // 'MISSINGNO',
	    'status'     => $params{'status'}     // 'VOID',
	    'properties' => $params{'properties'} // {},
	};

    bless($self,$class);
    return $self;
}

sub get_id          { return $_[0]->{'id'}; }

sub get_name        { return $_[0]->{'name'}; }

sub get_status      { return $_[0]->{'status'}; }

sub set_name {
    my ( $self, $name ) = @_;
    $self->{'name'} = $name;
    return 1;
}

sub set_property {
    my ( $self, $p_key, $p_value ) = @_;
    $self->{'properties'}->{$p_key} = $p_value;
    return 1;
}

sub get_property {
    my ( $self, $p_key ) = @_;
    return $self->{'properties'}->{$p_key};
}

sub set_status {
    my ( $self, $status ) = @_;
    $self->{'status'} = $status;
    return $self->{'status'};
}

sub properties {
    return wantarray ? %{ $_[0]->{'properties'} } : $_[0]->{'properties'};
}

1;
