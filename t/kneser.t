use strict;
use warnings;
use Test::More tests => 3;

use Graph;
use Graph::Maker;
use Graph::Maker::Kneser;

require 't/matches.pl';

my $g;

# directed
$g = new Graph::Maker('Kneser', k => 2, n => 5, undirected => 1);
is($g->vertices, 10);
is($g->edges, 15);
is(10, grep { $g->degree($_) == 3 } $g->vertices);
