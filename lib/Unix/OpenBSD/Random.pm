# -*- Perl -*-

package Unix::OpenBSD::Random;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw/arc4random arc4random_buf arc4random_uniform/;

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Unix::OpenBSD::Random', $VERSION);

sub arc4random_buf { die "not implemented" }

# see Random.xs for the code

1;
__END__

=head1 NAME

Unix::OpenBSD::Random - interface to arc4random(3) on OpenBSD

=head1 SYNOPSIS

TODO

=head1 AUTHOR

thrig - Jeremy Mates (cpan:JMATES) C<< <jmates at cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2018 by Jeremy Mates

This program is distributed under the (Revised) BSD License:
L<http://www.opensource.org/licenses/BSD-3-Clause>

=cut
