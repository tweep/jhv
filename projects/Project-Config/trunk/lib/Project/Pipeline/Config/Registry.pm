                             
package Project::Pipeline::Config::Registry;


=head1 DESCRIPTION

Registry object which knows about all our configs.

=head1 SYNOPSIS

  use Project::Pipeline::Config::Registry;
  my $registry = Project::Pipeline::Config::Registry->new(); 
  $registry->add_manager( 
                          Project::Project::Config::Manager->new(); 
                        ); 
=cut

use Moose;

with 'Project::Pipeline::Role::Registry' ; 




__PACKAGE__->meta->make_immutable; 

1;
