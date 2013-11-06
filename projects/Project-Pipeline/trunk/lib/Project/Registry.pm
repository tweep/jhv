                             
package Project::Registry;


=head1 DESCRIPTION

Registry object which knows about all our configs.

=head1 SYNOPSIS

  use Project::Registry;
  my $registry = Project::Registry->new();  

  $registry->add_manager( 
                          Project::Registry::Manager->new(); 
                        ); 
=cut

use Moose;

has 'manager' => (
          traits    => ['Hash'],
          is        => 'ro',
          isa       => 'HashRef[Project::Registry::Manager]',
          default   => sub { {} },
          handles   => {
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
