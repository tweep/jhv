
use strict;
use warnings;

use Data::Section -setup;
use Dist::Zilla::Tester;
use File::Temp qw( tempdir );
use Test::Most;

my $tempdir = tempdir( CLEANUP => 1 );
my $zilla = Dist::Zilla::Tester->from_config( { dist_root => 'corpus/basic', },
                                              { tempdir_root => $tempdir, } );

my $expected_plugins = __PACKAGE__->section_data('EXPECTEDPLUGINS');
my @expected_plugins = split("\n", $$expected_plugins);
my @GNE_expected_plugins =
  grep {/^\@GNE.*/} @expected_plugins; # discard builtins

my @got_plugins = map { $_->plugin_name } @{ $zilla->plugins };
my @GNE_got_plugins =
  grep {/^\@GNE.*/} @got_plugins; # discard builtins

cmp_deeply(\@GNE_got_plugins,
           bag(@GNE_expected_plugins),
           "Check that plugins we expect in bundle are present");

done_testing();

__DATA__
__[EXPECTEDPLUGINS]__
@GNE/AutoVersion
@GNE/GatherDir
@GNE/PruneCruft
@GNE/ManifestSkip
@GNE/NextRelease
@GNE/PkgVersion
@GNE/PodWeaver
@GNE/License
@GNE/ReadmeFromPod
@GNE/Test::Compile
@GNE/MetaTests
@GNE/PodSyntaxTests
@GNE/PodCoverageTests
@GNE/Test::Version
@GNE/AutoPrereqs
@GNE/Prereqs
@GNE/MetaNoIndex
@GNE/MetaProvides::Package
@GNE/MetaYAML
@GNE/MetaJSON
@GNE/ExecDir
@GNE/ShareDir
@GNE/ModuleBuild
@GNE/InstallGuide
@GNE/Manifest
@GNE/CheckExtraTests
@GNE/TestRelease
@GNE/Subversion::CommitCheck
@GNE/ConfirmRelease
@GNE/Pinto::Add
@GNE/Subversion::ReleaseDist
@GNE/Subversion::CommitChanges
@GNE/Subversion::Tag
:InstallModules
:IncModules
:TestFiles
:ExecFiles
:ShareFiles
:MainModule
