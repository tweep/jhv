
package Project::Registry::Role::General;

use Moose::Role;
use namespace::autoclean;

requires '_build_samplehub_view_version', '_build_etl_tmp_dir';

has 'samplehub_view_version' => (
    is       => 'rw',
    isa      => 'Maybe[Str]',
    required => 0,
    builder  => '_build_samplehub_view_version'
);
has 'etl_tmp_dir' => (
    is       => 'rw',
    isa      => 'Maybe[Str]',
    required => 0,
    builder  => '_build_etl_tmp_dir'
);

1;

