
# This file provides tests for the Project::Registry::Manager class

use strict;
use Project::Registry::Manager;
use Project::Registry::Manager::Config::Dataset;

use Test::More tests => 19;

my $manager = new_ok("Project::Registry::Manager");

# Create some example data set objects to test:
my %data_sets = (
    "cgp_3" => {
        "vp_variation_db" => "vp_1",
        "etl_db_name"     => "etl_1",
        "variant_caller"  => "gneCaller.1",
    },
    "tcga_06" => {
        "vp_variation_db" => "vp_2",
        "etl_db_name"     => "etl_2",
        "variant_caller"  => "gGATK",
      }

);

# Add the examle data sets from above to the Project::Registry::Manager
for my $ds ( keys %data_sets ) {
    ok(
        $manager->add_config(
            $ds => Project::Registry::Manager::Config::Dataset->new(
                %{ $data_sets{$ds} }
            )
        ),
        "adding config for $ds"
    );
} 

# Check if the default values are correct / not overwritten
my %default_values = (
    'base_dir'                => "_default_base_dir",
    'xml_dumps_annotated_dir' => "_default_base_dir/xml_annotated",
    'xml_dumps_merged_dir'    => "_default_base_dir/xml_merged",
    'ensembl_cvs_root_dir'    => "_default_ensembl_cvs_root_dir",
);

for my $ds ( keys %data_sets ) {
    for my $key ( keys %default_values ) {
        my $value = $default_values{$key};
        is( $value, $manager->get_config($ds)->$key(), $key );
    }
} 

# Check if the configuration from above is correct and overwrote the default values:
for my $ds ( keys %data_sets ) {
    for my $method ( keys %{ $data_sets{$ds} } ) {
        is(
            $manager->get_config($ds)->$method(),
            $data_sets{$ds}{$method},
            "correct $method for $ds"
        );
    }
}


# Test the manager : 
is(2,$manager->count_configs,"number of configs"); 
is("cgp_3,tcga_06",join(",",sort $manager->get_configs()),"configs successfully registered");
