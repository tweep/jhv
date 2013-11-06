
=head1 DESCRIPTION

Base class for all Configuration objects.

All Project::Pipeline::Config::***::Entry objects inherit fromt his class.

This class holds the default which are shared between all ::Entry objects, as they all 
inherit from this class.

If a configuration value is NOT defined, check first if we have a default value in the super-class, 
otherwise, throw.

=head1 SYNOPSIS

  use Project::Pipeline::GlobalConfig; 
  my $entry = Project::Pipeline::Config::DataSet::Entry->new();
 
  $entry->vp_variation_db("abc"); 
  $entry->etl_db_name("etl_db_name");

=cut 

package Project::Registry::Manager::Config;

use Moose;
with 'Project::Registry::Role::Config';

# We use a role here - we can overwrite the _build methods in the subclasses.

sub _build_species{
    return "Homo sapiens";
}


__PACKAGE__->meta->make_immutable;

1;
