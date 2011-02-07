
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Module::Build' => '0.3601'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Add autochomping capability to File::Slurp',
  'dist_author' => [
    'Steven Haryanto <stevenharyanto@gmail.com>'
  ],
  'dist_name' => 'File-Slurp-Chomp',
  'dist_version' => '0.01',
  'license' => 'perl',
  'module_name' => 'File::Slurp::Chomp',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'File::Slurp' => '0',
    'perl' => '5.010000'
  },
  'script_files' => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
