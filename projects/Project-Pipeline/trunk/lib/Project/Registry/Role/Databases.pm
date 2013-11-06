
package Project::Registry::Role::Databases;

use Moose::Role;
use namespace::autoclean;

requires
  '_build_host',
  '_build_user',
  '_build_pass',
  '_build_port',
  '_build_species';

has 'host' =>
  ( is => 'rw', isa => 'Str', required => 0, builder => '_build_host' );
has 'user' =>
  ( is => 'rw', isa => 'Str', required => 0, builder => '_build_user' );
has 'pass' =>
  ( is => 'rw', isa => 'Str', required => 0, builder => '_build_pass' );
has 'port' =>
  ( is => 'rw', isa => 'Str', required => 0, builder => '_build_port' );
has 'species' =>
  ( is => 'rw', isa => 'Str', required => 0, builder => '_build_species' );

has 'dbname' => ( is => 'rw', isa => 'Str', required => 0 );
has 'group'  => ( is => 'rw', isa => 'Str', required => 0 );

1;

