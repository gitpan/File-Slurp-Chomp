package File::Slurp::Chomp;
BEGIN {
  $File::Slurp::Chomp::VERSION = '0.02';
}
# ABSTRACT: Add autochomping capability to File::Slurp

use 5.010; # yes, i know, i'm spoilt.
use strict;
use warnings;

use File::Slurp qw();

our @my_replace  = qw(read_file    slurp);
our @my_exportok = qw(read_file_c  slurp_c
                      read_file_cq slurp_cq
                      read_file_q  slurp_q);

use base qw(Exporter);
our %EXPORT_TAGS = %File::Slurp::EXPORT_TAGS;
our @EXPORT      = @File::Slurp::EXPORT;
our @EXPORT_OK   = (@File::Slurp::EXPORT_OK, @my_exportok);

no strict 'refs';
# import all of File::Slurp, except our own replacement
for (@File::Slurp::EXPORT, @File::Slurp::EXPORT_OK) {
    *{$_} = \&{"File::Slurp::".$_} unless $_ ~~ @my_replace;
}

sub read_file {
    my ($path, %opts) = @_;
    my $wa = wantarray;

    my $res;
    my @res;
    if ($wa) {
        @res = File::Slurp::read_file($path, %opts);
        if ($opts{chomp}) { chomp for @res }
        return @res;
    } else {
        $res = File::Slurp::read_file($path, %opts);
        if ($res && $opts{chomp}) { chomp $res }
        return $res;
    }
}
*slurp = \&read_file;

sub read_file_cq {
    my ($path, %opts) = @_;
    $opts{err_mode} //= 'quiet';
    $opts{chomp}    //= 1;
    read_file($path, %opts);
}
*slurp_cq = \&read_file_cq;

sub read_file_c {
    my ($path, %opts) = @_;
    $opts{chomp}    //= 1;
    read_file($path, %opts);
}
*slurp_c = \&read_file_c;

sub read_file_q {
    my ($path, %opts) = @_;
    $opts{err_mode} //= 'quiet';
    read_file($path, %opts);
}
*slurp_q = \&read_file_q;

1;


=pod

=head1 NAME

File::Slurp::Chomp - Add autochomping capability to File::Slurp

=head1 VERSION

version 0.02

=head1 SYNOPSIS

Instead of:

 use File::Slurp qw(slurp ...);

use:

 use File::Slurp::Chomp qw(slurp ...);

and in addition to File::Slurp's features, you can also:

 my $scalar = read_file('path', chomp=>1);
 my @array  = slurp    ('path', chomp=>1);

You can also import B<read_file_cq> or B<slurp_cq> (short for "chomp & quiet")
as a shortcut for:

 read_file('path', chomp=>1, err_mode=>'quiet', ...);

=head1 DESCRIPTION

Autochomping is supposed to be in the upcoming version of L<File::Slurp>, but
I'm tired of waiting so this module is a band-aid solution. It wraps read_file()
(and slurp()) so it handles the B<chomp> option.

This module also offers B<read_file_cq> (or B<slurp_cq>), so if you like me
often write this:

 my $var   = read_file('/some/config/var', err_mode=>'quiet');
 chomp($var) if defined($var);

 my @lines = read_file('/some/config/file', err_mode=>'quiet');
 chomp for @lines;

you can now write this:

 my $var   = slurp_cq('/some/config/var');
 my @lines = slurp_cq('/some/config/file');

=head1 FUNCTIONS

=for Pod::Coverage (append_file|overwrite_file|read_dir|read_file|slurp|write_file)

For the list of functions available, see File::Slurp. Below are functions
introduced by File::Slurp::Chomp:

=head2 read_file_c($path, %opts)

Shortcut for:

 read_file('path', chomp=>1, ...)

Alias: slurp_c

=head2 read_file_cq($path, %opts)

Shortcut for:

 read_file('path', chomp=>1, err_mode=>'quiet', ...)

Alias: slurp_cq

=head2 read_file_q($path, %opts)

Shortcut for:

 read_file('path', err_mode=>'quiet', ...)

Alias: slurp_q

=head1 SEE ALSO

L<File::Slurp>, obviously.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


1;
