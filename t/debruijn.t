use strict;
use warnings;
use Test::More tests => 3;

use Graph;
use Graph::Maker;
use Graph::Maker::DeBruijn;

my $g;

# directed
$g = new Graph::Maker('DeBruijn', m => 2, n => 1);
is($g->vertices(), 2);
is($g->edges(), 4);
is(2, grep { $g->has_edge($_,$_) } $g->vertices());
