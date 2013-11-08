package RPG::Item;

use warnings;
use strict;

sub new {
    my ( $class, %params ) = @_;

    my $self =
	{
	    'id'         => $params{'id'}         // 0,
	    'name'       => $params{'name'}       // 'MISSINGITEM',
	    'status'     => $params{'status'}     // 'OK',
	    'value'      => $params{'value'}      // 0,
	    'properties' => $params{'properties'} // {},
	};

    bless($self,$class);
    return $self;
}

sub get_id          { return $_[0]->{'id'}; }
sub get_name        { return $_[0]->{'name'}; }
sub get_value       { return $_[0]->{'value'}; }
sub get_status      { return $_[0]->{'status'}; }
sub get_properties  { return $_[0]->{'properties'}; }

sub get_property {
    my ( $self, $p_key ) = @_;
    return $self->{'properties'}->{$p_key};
}

sub set_name {
    my ( $self, $name ) = @_;
    $self->{'name'} = $name;
    return 1;
}

sub set_property {
    my ( $self, $property, $value ) = @_;
    $self->{'properties'}->{$property} = $value;
    return 1;
}

sub set_status {
    my ( $self, $status ) = @_;
    $self->{'status'} = $status;
    return $self->{'status'};
}

1;
