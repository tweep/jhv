package Dist::Zilla::PluginBundle::GNE;

# ABSTRACT: Build the way we do at Genentech.


use Moose;
with 'Dist::Zilla::Role::PluginBundle::Easy';


sub configure {
  my ($self) = @_;

  # default pinto repository is here:
  my $repos = 'http://gpan.gene.com:3000';
  # it can be overridden in the GNE Bundle with a pinto_repository = ... line
  my $pinto_repository_info = $self->config_slice('pinto_repository');
  if (defined $pinto_repository_info->{pinto_repository} ) {
    $repos = $pinto_repository_info->{pinto_repository};
  }

  # the default set of releasers for GNE
  my @releaser_plugins =
    (
     # releasers
     ['Pinto::Add' => {repos => $repos} ],
     'Subversion::ReleaseDist',

     # commit NextReleases updates to Changes file
     'Subversion::CommitChanges',     # runs after_release
     'Subversion::Tag',               # runs after_release
    );

  # check and see if someone specified a releaser, if so use it...
  my $releaser_info = $self->config_slice( 'releaser' );
  if (defined $releaser_info->{releaser}) {
    @releaser_plugins = ( $releaser_info->{releaser} );
  }

  $self->add_plugins(
                     ['AutoVersion' =>
                      $self->config_slice( {'autoversion_major' => 'major'} ) ],
                     'GatherDir',
                     'PruneCruft',
                     'ManifestSkip',

                     # file modifiers
                     'NextRelease',
                     'PkgVersion',
                     'PodWeaver',

                     # file generators
                     'License',
                     'ReadmeFromPod',

                     # build t tests
                     ['Test::Compile' => {fake_home => 1}],

                     # build xt tests
                     'MetaTests',
                     'PodSyntaxTests',
                     'PodCoverageTests',
                     'Test::Version',

                     # assemble metadata
                     'AutoPrereqs',
                     'Prereqs',
                     ['MetaNoIndex' => {directory => ['t','xt']}],
                     ['MetaProvides::Package' => {meta_noindex => 1}],
                     'MetaYAML',
                     'MetaJSON',

                     # build system stuff
                     'ExecDir',
                     'ShareDir',
                     'ModuleBuild',
                     'InstallGuide',
                     # build a MANIFEST, after everythings been generated....
                     'Manifest',

                     # checks before release
                     'CheckExtraTests',
                     'TestRelease',
                     'Subversion::CommitCheck',

                     # release
                     # make user type yes
                     'ConfirmRelease',

                     @releaser_plugins,

                    );
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::PluginBundle::GNE - Build the way we do at Genentech.

=head1 VERSION

version 2.112940

=head1 DESCRIPTION

This bundle is meant to do just about everything needed for building a
GPAN distribution the way that we do at Genentech.

It includes the following plugins, generally with their default
configuration.  Some plugins have specific attributes preset
(documented below) and some can have particular attributes overridden
as described.  If you have to do something fancier, you'd better
already know how to do it....

By default the bundle releases using Subversion::ReleaseDist and
Pinto::Add.  You change that using the bundle's releaser argument, e.g.

  [@GNE]
  releaser = FakeRelease

=over

=item AutoVersion

You can set Autoversion's major number by setting this bundle's
autoversion_major parameter, e.g.

  [@GNE]
  autoversion_major = 42

=item GatherDir

=item PruneCruft

=item ManifestSkip

=item NextRelease

=item PkgVersion

=item PodWeaver

=item License

=item ReadmeFromPod

=item Test::Compile

With:
  fake_home => 1

=item MetaTests

=item PodSyntaxTests

=item PodCoverageTests

=item Test::Version

=item AutoPrereqs

=item Prereqs

=item MetaNoIndex

With:
  directory => ['t','xt']

=item MetaProvides::Package

With:
  meta_noindex => 1

=item MetaYAML

=item MetaJSON

=item ExecDir

=item ShareDir

=item ModuleBuild

=item InstallGuide

=item Manifest

=item CheckExtraTests

=item TestRelease

=item Subversion::CommitCheck

=item ConfirmRelease

=item Pinto::Add

You can set Pinto::Add's repos attribute/configuration parameterby
setting this bundle's pinto_repository parameter, e.g.

  [@GNE]
  pinto_repository = "http://gpan.foo.com:4242"

The default value is http://gpan.gene.com:3000'.

=item Subversion::ReleaseDist

=item Subversion::CommitChanges'

=item Subversion::Tag'

=back

=head1 METHODS

=head2 configure

=head1 AUTHOR

George Hartzell

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Genentech.

This is unreleased software and should not be distributed outside of
Genentech.

All rights reserved.

=cut

