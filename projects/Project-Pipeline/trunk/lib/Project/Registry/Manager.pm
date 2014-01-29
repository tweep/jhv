
package Project::Registry::Manager;

=head1 DESCRIPTION

Manager object which knows about the different configurations for different classes. 

=head1 SYNOPSIS

  use Project::Pipeline::Config::Manager; 

  my $registry = Project::Pipeline::Registry->new();    

  my $config_manager = Project::Pipeline::Config::Manager->new();    

  my $default = Project::Pipeline::Config::Dataset->new();
  $default->directory('abc'); 
  $default->filter_threshold('100'); 

  my $data_set = Project::Pipeline::Config::Dataset->new();    
  $data_set->directory('abc'), 
  $data_set->filter_threshold('100'); 
  
  $config_manager->add_config($data_set); 

  $registry->add_manager($config_manager);  

=cut

use Moose;
use Project::Registry::Utils::Tools;    # merge_config_sections
use Module::Load;
use Data::Dumper; 

=head2 create_config_objects()

Arg [1]    : String, i.e. Project::Registry::Manager::Config::Dataset
Arg [2]    : HashRef, Configuration Hash retrieved from different Adaptors / JSON parsing

Example    : Basically this is what's happening in Project::Registry->setup_config():

            my $registry = Project::Registry->new();

            for my $module_name ( keys %$config_hash ) {

                my $config_manager = Project::Registry::Manager->new();  
                $config_manager->create_config_objects($module_name, $config_hash); 
                $registry->add_manager( $module_name => $config_manager );

            }

Description: Creates Config objects for each sub-configured entity (data set)
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
    my ( $self, $module_name, $config_hash ) = @_;

    my $config_section = $config_hash->{$module_name};

    load $module_name;    # Module::Load,
    # load Project::Registry::Manager::Config::Dataset on the fly

    my $default_section_config = create_default_config_section_obj($module_name,$config_section);

    my %data_sets = %{ $config_section->{dataset} };


    #
    #  Loop trough all configured sets of a config section
    #
    if (scalar keys %data_sets > 0 ) { 
        
        for my $data_set ( keys %data_sets ) {
            my $merged_conf = merge_config_sections( $default_section_config,
                $data_sets{$data_set} );

           #
           # Add the detailed parameters of the config section to the config object:
           #

            my $config_obj = $module_name->new($merged_conf);    #$data_sets{$data_set});
            $self->add_config( $data_set => $config_obj );
        } 
     }else {  
            $self->add_config( 'DEFAULT' => $default_section_config ); 
     }

    return $self;
}

has 'config' => (
    traits  => ['Hash'],
    is      => 'ro',
    isa     => 'HashRef[Any]',
    default => sub { {} },
    handles => {
        add_config    => 'set',
        get_explicit_config    => 'get',
        get_configs   => 'keys',
        config_exists => 'defined',
        count_configs => 'count',
    },
);

sub get_config { 
    my ( $self, $config_name  ) = @_;  

    my $config = $self->get_explicit_config($config_name);  

    if (! defined $config ) { 
      $config = $self->get_explicit_config("DEFAULT");
    }  
    return $config;
} 

__PACKAGE__->meta->make_immutable;

1;
