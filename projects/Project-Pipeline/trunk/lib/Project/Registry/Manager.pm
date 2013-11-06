                             
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


has 'config' => (
    traits  => ['Hash'],
    is      => 'ro',
    isa     => 'HashRef[Any]',
    default => sub { {} },
    handles => {
        add_config    => 'set',
        get_config    => 'get',
        get_configs   => 'keys',
        config_exists => 'defined',
        count_configs => 'count',
    },
);



__PACKAGE__->meta->make_immutable; 

1;
