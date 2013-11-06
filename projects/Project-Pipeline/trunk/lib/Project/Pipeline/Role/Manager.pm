
package Project::Pipeline::Role::Manager;

use Moose::Role;
use namespace::autoclean;

has 'config' => (
    traits  => ['Hash'],
    is      => 'ro',
    isa     => 'HashRef[Any]',
    default => sub { {} },
    handles => {
        add_config    => 'set',
        get_config    => 'get',
        configs       => 'keys',
        config_exists => 'defined',
        count_configs => 'count',
    },
);

1;

