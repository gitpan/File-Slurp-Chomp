#!perl -T

use 5.010;
use strict;
use warnings;

use Test::More tests => 2;

use File::Temp qw(tempdir);
use File::Slurp::Chomp qw(write_file read_file_cq slurp_cq);

my $dir = tempdir(CLEANUP => 1);

write_file("$dir/1", "test\n");
is(read_file_cq("$dir/1"), "test", 'autochomping');
ok(!defined(slurp_cq("$dir/2")), 'quiet');
