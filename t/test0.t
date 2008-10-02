# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

use Test::More tests => 2;

BEGIN { use_ok('MIKER::CPAN::ForceSmokerTest'); }
my $loaded = 1;
END {print "not ok 1\n" unless $loaded;}

my $pagesize;
ok( $pagesize = MIKER::CPAN::ForceSmokerTest::myreturn0(), "PAGE_SIZE = $pagesize");
