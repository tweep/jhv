
package Project::Pipeline::Role::Config;

use Moose::Role;
use namespace::autoclean;

requires '_build_vp_variation_db','_build_etl_db_name';

has 'vp_variation_db' => (
    is       => 'rw',
    isa      => 'Str',
    required => 0,
    builder  => '_build_vp_variation_db'
);

has 'etl_db_name' => (
    is       => 'rw',
    isa      => 'Str',
    required => 0,
    builder  => '_build_etl_db_name'
); 



1;

