                             
package Project::Pipeline::Config::Manager;


=head1 DESCRIPTION

Manager object which knows about the different configurations for different classes. 

=head1 SYNOPSIS

  use Project::Pipeline::Config::Manager; 

  my $registry = Project::Pipeline::Config::Registry->new();   

  my $default = Project::Pipeline::Config::DataSet->new();    
  $default->directory('abc'), 
  $default->filter_threshold('100'); 

  my $manager = Project::Pipeline::Config::Manager->new();    
  $manager->default_config($default); 

  my $data_set = Project::Pipeline::Config::DataSet->new();    
  $data_set->directory('abc'), 
  $data_set->filter_threshold('100'); 
  
  $manager->add_config($data_set);

=cut

use Moose;

with 'Project::Pipeline::Role::Manager' ; 





__PACKAGE__->meta->make_immutable; 

1;
