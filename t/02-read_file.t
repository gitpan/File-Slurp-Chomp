#!perl -T

use 5.010;
use strict;
use warnings;

use Test::More tests => 2;

use File::Temp qw(tempfile);
use File::Slurp::Chomp;

my ($fh, $filename);
($fh, $filename) = tempfile();

write_file($filename, "test\n");
is(read_file($filename, chomp=>0), "test\n", 'no chomp');
is(read_file($filename, chomp=>1), "test"  , 'chomp');


