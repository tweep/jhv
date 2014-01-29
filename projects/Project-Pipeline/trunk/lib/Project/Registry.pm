

# ABSTRACT: Main module which initializes configuration files

=head1 DESCRIPTION

Registry object which knows about all our configs and initializes them.
The configuration is build from a Hash of Hashes.

=head1 SYNOPSIS

  use Project::Registry;
  my $registry = Project::Registry->new();
  my $registry->setup_config($js); 

  OR 

  my $manager = Project::Registry::Manager->new(); 
  $registry->add_manager( $manager );  

=cut

package Project::Registry;
use Moose;
use Project::Registry::Manager;
use Log::Log4perl qw(:easy);
use Data::Dumper; 



=head2 setup_config

Arg [1]    : HashReference  
Example    : my $registry = process_config($hash_ref);  
Description: Values can be passed via a HashReference / JSON file.
             Default can be hard-coded and set in various sub-classes.

             For example, the DEFAULT database connection details can be hard-coded in 

               Project::Registry::Manager::Config::Database 

An example of the $hash_ref_config looks like this:   

use Project::Registry;

my $js = 
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
   },
   "Project::Registry::Manager::Config::ExampleConfig" : {
      "DEFAULT" : {
         "port" : "config_9306",
      },
      "dataset" : {
         "cgi_wgs" : {
            "dbname" : "my_db_name"
         }
   }
 }
};  

  my $registry = Project::Registry->new();
  my $registry->setup_config($js); 
  my $manager = $registry->get_manager("Project::Registry::Manager::Config::Database");  

=cut


sub setup_config {
    my ($self, $config_hash) = @_;

    for my $module_name ( keys %$config_hash ) {
        INFO("Processing $module_name");
        my $config_manager = Project::Registry::Manager->new();  
        $config_manager->create_config_objects($module_name, $config_hash);  
        $self->add_manager( $module_name => $config_manager );

    }
    return $self;
}


has 'manager' => (
    traits  => ['Hash'],
    is      => 'ro',
    isa     => 'HashRef[Project::Registry::Manager]',
    default => sub { {} },
    handles => {
        add_manager    => 'set',
        get_manager    => 'get',
        managers       => 'keys',
        manager_exists => 'defined',
        count_managers => 'count',
    },
);

1;

__PACKAGE__->meta->make_immutable;

1;
