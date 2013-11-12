#!/usr/bin/env perl

use warnings;
use strict;

use lib '../lib';

use RPG::Engine;

exit(main());

sub main {
    my $engine = RPG::Engine->new();
    $engine->load();
    return $engine->run();
}
