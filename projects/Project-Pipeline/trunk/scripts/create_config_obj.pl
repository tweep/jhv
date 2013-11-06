#!/usr/local/bin/env perl 

use strict;
use warnings;

use Getopt::Long;
use Log::Log4perl qw(:easy);
use Log::Log4perl::CommandLine qw(:all);
use Log::Log4perl::CommandLine ':all', ':loginit' => { level => $WARN };
use autodie;
use Module::Load;
use JSON;
use Data::Dumper;
use Project::Registry::Utils::Tools; 

use Project::Registry;
use Project::Registry::Manager;

my $file = "test.json";

&GetOptions( 'config=s' => \$file, );

my $js     = read_json_file($file);
my $vp_reg = process_config($js);

print Dumper($vp_reg);


=head2 process_config

Arg [1]    : HashReference  
Example    : my $registry = process_config($hash_ref);  
Description: An example of the $hash_ref_config looks like this:  

{
   "Project::Registry::Manager::Config::Database" : {
      "DEFAULT" : {
         "host" : "config_test01",
         "port" : "config_9306",
         "pass" : "config_password",
         "user" : "config_myuser"
      },
      "dataset" : {
         "cgi_wgs" : {
            "dbname" : "my_db_name"
         }
      }
   }
}

=cut

sub process_config {
    my ($config_hash) = @_;

    my $registry = Project::Registry->new();

    for my $module ( keys %$config_hash ) {
        load $module; # loads a class,i.e. Project::Registry::Manager::Config::Database

        my %config_section = %{ $config_hash->{$module} };

        my $config_manager = create_config_objects( $module, \%config_section );
        $registry->add_manager( $module => $config_manager );
    }
    return $registry;
}


=head2 create_config_objects()

Arg [1]    : 
Example    : 
Description: Creates Config objects for eaach data set 
             and registers the objects with the Project::Registry::Manager class.

             The configuration hierarchy is:

              - DEFAULT values from the installed classes like 
                Project::Registry::Manager::Config::Database are 
                overwritten by 
              - DEFAULT values in the input file, which are overwritten by
              - the section data                 

Returntype : 
Exceptions : 


=cut


sub create_config_objects {
    my ( $module, $config_section ) = @_; 

    # The manager object knows all about it the config sections of one type.
    my $config_manager = Project::Registry::Manager->new();

    my $default_section_config = create_default_config_section_obj( $module, $config_section );

    my %data_sets = %{ $config_section->{dataset} };

    #
    #  Loop trough all configured sets of a config section
    #

    for my $data_set ( keys %data_sets ) {  
        my $merged_conf = merge_config_sections($default_section_config, $data_sets{$data_set});
        #
        # Add the detailed parameters of the config section to the config object:  
        # 

        my $config_obj = $module->new($merged_conf); #$data_sets{$data_set}); 
        $config_manager->add_config( $data_set => $config_obj );
    }
    return $config_manager;
}




sub create_default_config_section_obj {
    my ( $module, $config ) = @_;

    if ( exists $config->{DEFAULT} ) {
        return $module->new( $config->{DEFAULT} );
    }
}



