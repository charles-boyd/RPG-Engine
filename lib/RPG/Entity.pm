package RPG::Entity;

use warnings;
use strict;

use Carp;
use Data::UUID;

sub new {
    my ( $class, %p_args ) = @_;

    my $self =
	{
	    'id'         => $p_args{'id'}         // Data::UUID->new()->create_str(),
	    'name'       => $p_args{'name'}       // 'NONAME',
	    'status'     => $p_args{'status'}     // 'OK',
	    'attributes' => $p_args{'attributes'} // { },
	    'properties' => $p_args{'properties'} // { },
	    'flags'      => $p_args{'flags'}      // { },
	    'meta'       => $p_args{'meta'}       // { },
	};

    bless($self,$class);
    return $self;
}

sub id             { return $_[0]->{'id'};         }
sub name           { return $_[0]->{'name'};       }
sub status         { return $_[0]->{'status'};     }
sub attributes     { return $_[0]->{'attributes'}; }
sub properties     { return $_[0]->{'properties'}; }
sub flags          { return $_[0]->{'flags'};      }
sub meta           { return $_[0]->{'meta'};       }

sub get_id         { return $_[0]->id();         }
sub get_name       { return $_[0]->name();       }
sub get_status     { return $_[0]->status();     }

sub has_attribute {
    my ( $self, $p_key ) = @_;
    return defined($self->{'attributes'}->{$p_key});
}

sub has_property {
    my ( $self, $p_key ) = @_;
    return defined($self->{'properties'}->{$p_key});
}

sub has_flag {
    my ( $self, $p_key ) = @_;
    return defined($self->{'flags'}->{$p_key});
}

sub has_meta {
    my ( $self, $p_key ) = @_;
    return defined($self->{'meta'}->{$p_key});
}

sub get_attribute {
    my ( $self, $p_key ) = @_;
    return $self->{'attributes'}->{$p_key};
}

sub get_attribute_keys {
    my ( $self  ) = @_;
    return keys %{ $self->{'attributes'} };
}

sub get_property {
    my ( $self, $p_key ) = @_;
    return $self->{'properties'}->{$p_key};
}

sub get_property_keys {
    my ( $self ) = @_;
    return keys %{ $self->{'properties'} };
}

sub get_flag {
    my ( $self, $p_key ) = @_;
    return $self->{'flags'}->{$p_key};
}

sub get_flag_keys {
    my ( $self, $p_key ) = @_;
    return keys %{ $self->{'flags'} };
}

sub get_meta {
    my ( $self, $p_key ) = @_;
    return $self->{'meta'}->{$p_key};
}

sub get_meta_keys {
    my ( $self ) = @_;
    return keys %{ $self->{'meta'} };
}

sub set_id {
    my ( $self, $p_id ) = @_;
    $self->{'id'} = $p_id;
    return 1;
}

sub set_name {
    my ( $self, $p_name ) = @_;
    $self->{'name'} = $p_name;
    return 1;
}

sub set_status {
    my ( $self, $status ) = @_;
    $self->{'status'} = $status;
    return 1;
}

sub set_attribute {
    my ( $self, $p_key, $p_value ) = @_;
    $self->{'attributes'}->{$p_key} = $p_value;
    return 1;
}

sub set_property {
    my ( $self, $p_key, $p_value ) = @_;
    $self->{'properties'}->{$p_key} = $p_value;
    return 1;
}

sub set_flag {
    my ( $self, $p_key, $p_value ) = @_;
    $self->{'flag'}->{$p_key} = $p_value;
    return 1;
}

sub set_meta {
    my ( $self, $p_key, $p_value ) = @_;
    $self->{'meta'}->{$p_key} = $p_value;
    return 1;
}

1;
