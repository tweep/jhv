
=head1 DESCRIPTION

Config object which holds the final configuration values. 

The default values for this class are set in the subroutines.


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

  use Project::Registry::Manager::Config::Dataset;  

  my $data_set_config = Project::Registry::Manager::Config::Dataset->new(
         "vp_variation_db" => "vogelj4_evar_2013_03_03_cgp3", 
         "etl_db_name" => "vogelj4_evar_2013_09_01_cgp3_etl", 
         "variant_caller" => "gneCaller.1"
    );

  If a value is not set / supplied, it's default value (see subroutines below) are used.
  All attributes are defined in the Role Project::Registry::Role::DataSet.
 
  $entry->vp_variation_db("abc"); 
  $entry->etl_db_name("etl_db_name");

=cut

package Project::Registry::Manager::Config::Dataset;
use Moose;
use namespace::autoclean;
use Data::Dumper;
use Class::MOP::Class;
use File::Spec::Functions;

extends 'Project::Registry::Manager::Config';
with 'Project::Registry::Role::DataSet', 'Project::Registry::Role::Config';

has 'default_class' => (
    is       => 'rw',
    isa      => 'Project::Registry::Manager::Config',
    required => 0,
    trigger  => \&set_all_defaults,
);

# Supply default values which over-rides the defaults from the base class

sub _build_base_dir {
    return "_default_base_dir";
}

sub _build_xml_dumps_annotated_dir {
    return catdir( shift->_build_base_dir(), "xml_annotated" );
}

sub _build_xml_dumps_merged_dir {
    return catdir( shift->_build_base_dir(), "xml_merged" );
}
sub _build_ensembl_cvs_root_dir { return "_default_ensembl_cvs_root_dir" }
sub _build_vp_variation_db      { return "_default_vp_variation_db" }
sub _build_etl_db_name          { return "_default_etl_db_name" }



sub set_all_defaults {
    my ( $self, $passed_val, $previous_val ) = @_;

    # Get the name of all attributes of the Class
    my $meta = $passed_val->meta();

    for my $attr ( $meta->get_all_attributes ) {
        my $attribute_name = $attr->name();
        my $default_value = $passed_val->$attribute_name();
        $self->attribute_name($default_value);
    }
}

__PACKAGE__->meta->make_immutable;

1;
