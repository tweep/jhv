
package Project::Registry::Role::AnnotateXML;

use Moose::Role;
use namespace::autoclean;

requires '_build_key_field_delimiter';

has 'key_field_delimiter' => (
    is       => 'rw',
    isa      => 'Maybe[Str]',
    required => 0,
    builder  => '_build_key_field_delimiter'
);

# Below arguments which come from the JSON config file
has 'xml_key_field'     => ( is => 'rw', isa => 'Maybe[ArrayRef[Str]]', required => 0 );
has 'annotation_module' => ( is => 'rw', isa => 'Maybe[ArrayRef[Str]]', required => 0 );
has 'constructor_args'  => ( is => 'rw', isa => 'Any'                 , required => 0 );
has 'annotation_file'   => ( is => 'rw', isa => 'Maybe[ArrayRef[Str]]', required => 0 );


1;

