use strict;
use warnings;
use Test::More tests => 8;

use Graph;
use Graph::Maker;
use Graph::Maker::DeBruijn;

my $g;

$g = new Graph::Maker('DeBruijn', m => 2, n => 1);
is($g->vertices(), 2);
is($g->edges(), 4);
is(2, grep { $g->has_edge($_,$_) } $g->vertices());
is(2, grep { $g->in_degree($_) == 2 && $g->out_degree($_) == 2 } $g->vertices());

$g = new Graph::Maker('DeBruijn', m => 2, n => 2);
is($g->vertices(), 4);
is($g->edges(), 8);
is(2, grep { $g->has_edge($_,$_) } $g->vertices());
is(4, grep { $g->in_degree($_) == 2 && $g->out_degree($_) == 2 } $g->vertices());
