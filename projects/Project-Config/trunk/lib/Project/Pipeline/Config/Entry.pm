                             


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

  use Project::Pipeline::Config::Entry;
  my $entry = Project::Pipeline::Config::Entry->new();  
 
  $entry->vp_variation_db("abc"); 
  $entry->etl_db_name("etl_db_name");


=cut

package Project::Pipeline::Config::Entry;
use Moose;
use namespace::autoclean;
use Data::Dumper; 
use Class::MOP::Class;
extends 'Project::Pipeline::Config';
with 'Project::Pipeline::Role::Config';

has 'default_class'      => (
                              is => 'rw' , 
                              #isa => 'Project::Pipeline::Config' , 
                              isa => 'Any', 
                              required => 0,
   #                               handles => { 
   #                                            bla => "vp_variation_db", 
   #                                          },
                               trigger => \&set_all_defaults, 
                            );



sub set_all_defaults {
      my ( $self, $passed_val, $previous_val) = @_;

      my $meta = $passed_val->meta();  

      for my $attr ( $meta->get_all_attributes ) { 
        my $attribute_name = $attr->name();
        print "Entry.pm: Setting defaults: " , $attr->name, " ==> ", $passed_val->$attribute_name, "\n"; 
        
      }
}


# Supply default values which over-rides the defaults from the base class 

sub _build_vp_variation_db {
    return "ENTRY VPP init value";
}

sub _build_etl_db_name {
    return "ENTRY ETL init value";
}



__PACKAGE__->meta->make_immutable; 

1;
