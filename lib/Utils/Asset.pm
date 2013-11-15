package Utils::Asset;

use warnings;
use strict;

use JSON::XS;
use File::Slurp qw{ read_file write_file };

require Exporter;
our @ISA = qw{ Exporter };
our @EXPORT = qw{ load_entity_by_id load_entity save_entity };

sub load_entity_by_id {
    my ( $p_id ) = @_;
    return load_asset(qq{/tmp/$p_id});
}

sub load_entity {
    my ( $p_file ) = @_;
    my $asset = read_file(qq{$p_file});
    return JSON::XS->new()->utf8()->pretty()->decode($asset);
}

sub save_entity {
    my ( $p_entity ) = @_;

    # my $entity_id = $p_entity->id();
    # my $json_str  = JSON::XS->new()->allow_blessed()->utf8()->pretty()->encode($p_entity);
    # write_file( qq{/tmp/$entity_id}, $json_str );

    return 1;
}

1;
