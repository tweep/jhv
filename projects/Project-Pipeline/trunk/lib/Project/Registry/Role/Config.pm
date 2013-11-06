
package Project::Registry::Role::Config;

use Moose::Role;
use namespace::autoclean;

# All classes which consume this role have to implement / overwrite '_build_species'
# '_build_species' is implemented in : 
# Project::Pipeline::GlobalConfig 
# 
requires '_build_species';

has 'species' => (
    is       => 'rw',
    isa      => 'Str',
    required => 0,
    builder  => '_build_species'
);


1;

