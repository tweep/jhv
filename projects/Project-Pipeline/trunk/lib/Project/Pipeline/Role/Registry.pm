
package Project::Pipeline::Role::Registry;

use Moose::Role;
use namespace::autoclean; 


has 'manager' => (
          traits    => ['Hash'],
          is        => 'ro',
          isa       => 'HashRef[Any]',
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



