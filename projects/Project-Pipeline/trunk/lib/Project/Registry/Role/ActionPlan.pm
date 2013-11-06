
package Project::Registry::Role::ActionPlan;

use Moose::Role;
use namespace::autoclean;

# Default values can be set up with '_builder' methods which 
# are implemented in Project::Registry::Manager::Config::ActionPlan

has 'dump_xml'       => ( is => 'rw', isa => 'Maybe[Str]', required => 0 );
has 'annotate_xml'   => ( is => 'rw', isa => 'Maybe[Str]', required => 0 );
has 'merge_data'     => ( is => 'rw', isa => 'Maybe[Str]', required => 0 );
has 'upload_to_solr' => ( is => 'rw', isa => 'Maybe[Str]', required => 0 );

1;

