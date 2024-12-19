package Graph::Maker::Kneser;

use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);
use Carp qw/croak/;
use base qw/Graph::Maker/;
use Graph;
use Set::Scalar;

our $VERSION = '0.01';

sub init
{
	my ($self, %params) = @_;

	my $k = delete($params{k}) || 0;
	my $n = delete($params{n}) || 0;
	my $gm = delete($params{graph_maker});
	croak "graph_maker must be a reference to a function that creates a Graph.\n" if $gm && ref($gm) ne 'CODE';
	$gm ||= sub { new Graph(@_); };

	croak "k must not exceed n\n" if $k > $n;

	my $g = $gm->(%params);

	my @combinations = map { Set::Scalar->new(@$_) } combinations([1..$n], $k);
	$g->add_vertices(1..$#combinations+1);

	for my $i (0..$#combinations) {
		for my $j (0..$#combinations) {
			$g->add_edge($i+1, $j+1) if $combinations[$i] != $combinations[$j];
		}
	}

	return $g;
}

Graph::Maker->add_factory_type( 'Kneser' => __PACKAGE__ );

1;
