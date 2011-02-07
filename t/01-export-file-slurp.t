#!perl -T

use 5.010;
use strict;
use warnings;

use Test::More tests => 1;

use File::Temp qw(tempfile);
use File::Slurp::Chomp;

my ($fh, $filename);
($fh, $filename) = tempfile();

write_file($filename, 'test');
is(read_file($filename), 'test',
   'read_file/write_file exported by default, just like with File::Slurp');


