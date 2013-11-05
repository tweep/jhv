
package Project::Pipeline::Config;

=head1 DESCRIPTION

Base class for all Entry objects - all Project::Pipeline::Config::Entry objects 
inherit fromt his class. 

This class holds the default values. 

If a configuration value is NOT defined, check first if we have a default value in the super-class, otherwise 
throw.

=head1 SYNOPSIS

  use Project::Pipeline::Config; 
  my $entry = Project::Pipeline::Config; 
 
  $entry->vp_variation_db("abc"); 
  $entry->etl_db_name("etl_db_name");

=cut

use Moose;
with 'Project::Pipeline::Role::Config';

sub _build_vp_variation_db {
    return "BASE CONFIG VPP INIT VALUE";
}

sub _build_etl_db_name {
    return "BASE CONFIG ETL INIT VALUE";
}

__PACKAGE__->meta->make_immutable;

1;
