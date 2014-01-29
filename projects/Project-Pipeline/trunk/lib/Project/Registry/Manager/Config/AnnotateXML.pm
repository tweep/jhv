
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

package Project::Registry::Manager::Config::AnnotateXML;
use Moose;
use namespace::autoclean;
use Data::Dumper;
use Class::MOP::Class;

extends 'Project::Registry::Manager::Config';

with 'Project::Registry::Role::AnnotateXML';

#
# Set default values which over-rides the defaults from the base class
#

sub _build_key_field_delimiter { return "-" }




=head2 create_key()

Arg [1]    : HashRef from XML::Dumper 
Example    : 
Description: Creates a key-string and uses the key field delmiter 
             specified in the configuration file. If no key field delimiter 
             is specified, it uses the DEFAULT key field delmiter '-'. 
Returntype : String 
Exceptions : None 


=cut


sub create_key { 
  my ($self, $record) = @_; 

  # Record is a hash who's values are arrays. This is 'cause we might have 
  # data in the SOLR document which has multiple times the same entry 
  # and we can't process this with a Hash ( overwrite the same key ... ) 
  # $record->{sample_id} = ['sam123'] 
  # $record->{xr_consequence_type} = ['INTRONIC','NON_SYNONYMOUS_CODING'] 


  my $aref_key_fields  =  $self->xml_key_field(); 
  my @key_values = map { ${ $record->{$_}}[0] } @$aref_key_fields; 

  my $separator = $self->key_field_delimiter(); 

  return  join($separator, @key_values); 

}


__PACKAGE__->meta->make_immutable;

1;
