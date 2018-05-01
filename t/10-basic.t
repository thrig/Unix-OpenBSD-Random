#!perl

use strict;
use warnings;

use Config;
use Scalar::Util qw(looks_like_number);
use Test::Most;    # test count is down at bottom
my $deeply = \&eq_or_diff;

use Unix::OpenBSD::Random qw(arc4random arc4random_buf arc4random_uniform);

########################################################################
#
# arc4random

my $x;
lives_ok { $x = arc4random() } 'arc4random should not die';
ok( looks_like_number($x) and $x =~ m/^\d+$/, 'got non-negative integer' );

########################################################################
#
# arc4random_buf

dies_ok { arc4random_buf(-1) } 'length must be non-negative';

my $len = 4 + int rand 8;
my $buf = arc4random_buf($len);
is( length $buf, $len ) or diag sprintf "len=$len got=%vx\n", $buf;

# mostly for something to copy into the perldocs
diag sprintf "%vx %s\n", $buf, unpack( "H*", $buf );

# some folks might instead want an error, but this is how the C behaves...
is( arc4random_buf(0), '', 'default behavior' );

########################################################################
#
# arc4random_uniform

lives_ok { arc4random_uniform(2) } 'arc4random_uniform should not die';
my %seen;
$seen{ arc4random_uniform(2) }++ for 1 .. 100;
$deeply->(
    [ sort { $a <=> $b } keys %seen ],
    [ 0, 1 ],
    "no strange coinflip results"
);
# TODO do a better statistical test... or worse, if this false positives...
ok( $seen{0} > 25 and $seen{1} < 75 );

my $bigbits = 0;
if ( $Config{ivsize} > 4 ) {
    dies_ok { arc4random_uniform(-1) } 'below uint32_t range';
    dies_ok { arc4random_uniform( ~0 ) } 'above uint32_t range';
    $bigbits = 2;
} elsif ( $Config{ivsize} == 4 ) {
    diag "no upper_bound limit tests on 32-bit system";
} else {
    diag "unknown ivsize $Config{ivsize} ??";
}

# some folks might instead want an error, but this is how the C behaves...
is( arc4random_uniform(0), 0, 'default behavior' );

done_testing( 9 + $bigbits );
