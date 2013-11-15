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

    my $now = time();
    my $ctime = $p_args{'ctime'} // $now;
    my $atime = $p_args{'atime'} // $now;
    my $mtime = $p_args{'mtime'} // $now;

    $self->set_meta('ctime',$ctime);
    $self->set_meta('mtime',$atime);
    $self->set_meta('mtime',$mtime);

    return $self->update();

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

sub ctime { return $_[0]->get_meta('ctime');  }
sub atime { return $_[0]->get_meta('atime');  }
sub mtime { return $_[0]->get_meta('mtime');  }
sub age   { return $_[0]->get_meta('age');    }

sub is_immutable   { return $_[0]->has_flag('immutable'); }
sub is_dirty       { return $_[0]->has_flag('_dirty');    }

sub update {
    my ( $self ) = @_;

    my $now = time();
    my $age = $now - $self->ctime();

    $self->set_meta('atime',$now);
    $self->set_meta('age',$age);

    if ( $self->is_dirty() ) {
	$self->set_meta('mtime',$now);
	$self->save();
    }

    return $self;
}

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
    $self->set_flag('_dirty',1);
    return 1;
}

sub set_name {
    my ( $self, $p_name ) = @_;
    $self->{'name'} = $p_name;
    $self->set_flag('_dirty',1);
    return 1;
}

sub set_status {
    my ( $self, $status ) = @_;
    $self->{'status'} = $status;
    $self->set_flag('_dirty',1);
    return 1;
}

sub set_attribute {
    my ( $self, $p_key, $p_value ) = @_;
    $self->{'attributes'}->{$p_key} = $p_value;
    $self->set_flag('_dirty',1);
    return 1;
}

sub set_property {
    my ( $self, $p_key, $p_value ) = @_;
    $self->{'properties'}->{$p_key} = $p_value;
    $self->set_flag('_dirty',1);
    return 1;
}

sub set_flag {
    my ( $self, $p_key, $p_value ) = @_;
    $self->{'flags'}->{$p_key} = $p_value;
    return 1;
}

sub set_meta {
    my ( $self, $p_key, $p_value ) = @_;
    $self->{'meta'}->{$p_key} = $p_value;
    return 1;
}

sub save {
    my ( $self ) = @_;

    # serialize to JSON and save to file somewhere

    $self->set_flag('_dirty',0);

    return 1;
}

1;
