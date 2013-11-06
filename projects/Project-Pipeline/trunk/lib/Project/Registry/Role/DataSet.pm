
package Project::Registry::Role::DataSet;

use Moose::Role;
use namespace::autoclean;

requires
  '_build_base_dir',
  '_build_xml_dumps_annotated_dir',
  '_build_xml_dumps_merged_dir',
  '_build_ensembl_cvs_root_dir',
  '_build_vp_variation_db',
  '_build_etl_db_name';

has 'base_dir' => (
    is       => 'rw',
    isa      => 'Str',
    required => 0,
    builder  => '_build_base_dir'
);

has 'xml_dumps_annotated_dir' => (
    is       => 'rw',
    isa      => 'Str',
    required => 0,
    builder  => '_build_xml_dumps_annotated_dir'
);

has 'xml_dumps_merged_dir' => (
    is       => 'rw',
    isa      => 'Str',
    required => 0,
    builder  => '_build_xml_dumps_merged_dir'
);

has 'ensembl_cvs_root_dir' => (
    is       => 'rw',
    isa      => 'Str',
    required => 0,
    builder  => '_build_ensembl_cvs_root_dir'
);

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

has 'json_vcf_file' => (
    is       => 'rw',
    isa      => 'Str',
    required => 0,
);

has 'variant_caller' => (
    is       => 'rw',
    isa      => 'Str',
    required => 0,
);

1;

