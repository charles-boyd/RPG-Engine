#!/usr/bin/env perl

use warnings;
use strict;

use lib '../lib';

use RPG::Engine;

exit(main());

sub main {
    my $engine = RPG::Engine->new();
    return $engine->run();
}
