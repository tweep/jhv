
=head1 DESCRIPTION

Config object which holds the final configuration values. 
This object holds configuration like this: 

                         "data_set_name" => {
                                       vp_variation_db => "vogelj4_evar_2013_03_03_cgp3",
                                       etl_db_name     => "vogelj4_evar_2013_09_01_cgp3_etl",
                                       json_vcf_file   => "/gne/re/json_strings/json_reformat.txt",
                                       variant_caller  =>  "gneCaller.1",
                                       xml_dump_dir    => "/path/to/alternative_dir_with_dumped_xml_files",
                                    },


If a configuration value is NOT defined, check first if we have a default value in the super-class, otherwise 
throw.

=head1 SYNOPSIS

  use Project::Registry::Manager::Config::Database;
  my $entry =Project::Registry::Manager::Config::Database->new();
 
  $entry->vp_variation_db("abc"); 
  $entry->etl_db_name("etl_db_name");


=cut

package Project::Registry::Manager::Config::Database;
use Moose;
use namespace::autoclean;
use Data::Dumper;
use Class::MOP::Class;

extends 'Project::Registry::Manager::Config';

with 'Project::Registry::Role::Databases';


#
# Set default values which over-rides the defaults from the base class
#
sub _build_host    { return 'resio01' }
sub _build_user    { return 'gneadmin' }
sub _build_pass    { return 'gne' }
sub _build_port    { return '9306' }
sub _build_species { return 'Homo sapiens' }

__PACKAGE__->meta->make_immutable;

1;
