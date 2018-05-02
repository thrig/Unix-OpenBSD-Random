#!perl

use strict;
use warnings;

use Test::Most;    # test count is down at bottom

use Unix::OpenBSD::Random ':all';

ok( exists &arc4random,         'arc4random exists' );
ok( exists &arc4random_buf,     'arc4random_buf exists' );
ok( exists &arc4random_uniform, 'arc4random_uniform exists' );

done_testing(3);
