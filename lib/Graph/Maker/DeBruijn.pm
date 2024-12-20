package Graph::Maker::DeBruijn;

use strict;
use warnings;
use Carp qw/croak/;
use base qw/Graph::Maker/;
use Graph;
use Graph::Maker::Complete;
use Graph::MoreUtils qw/line/;

our $VERSION = '0.01';

sub init
{
	my ($self, %params) = @_;

	my $m = delete($params{m}) || 0;
	my $n = delete($params{n}) || 0;
	my $gm = delete($params{graph_maker});
	croak "graph_maker must be a reference to a function that creates a Graph.\n" if $gm && ref($gm) ne 'CODE';
	$gm ||= sub { new Graph(@_); };

	my $g = Graph::Maker->new('complete', N => $m, graph_maker => $gm, %params);
	for (1..$n) {
		$g = line( $g );
	}

	return $g;
}

Graph::Maker->add_factory_type( 'DeBruijn' => __PACKAGE__ );

1;
