
use strict;
use Project::Pipeline::Config;
use Project::Pipeline::Config::Entry;
use Test::Exception;
use Test::More tests => 6;


my $default = new_ok("Project::Pipeline::Config"); 

$default->vp_variation_db("new_vp_variation_db");
$default->etl_db_name("new_etl_db_name");

#
# Create new Entry obj
# 


my $entry = new_ok("Project::Pipeline::Config::Entry");

# Both  Project::Pipeline::Config and  Project::Pipeline::Config::Entry
# consume the ROLE : Project::Pipeline::Role::Config

#
# The initial/default values are set by the _build_* methods in
# Project::Pipeline::Config and Project::Pipeline::Config::Entry
#

is( "ENTRY_VPP_INIT_VALUE", $entry->vp_variation_db() );
is( "ENTRY_ETL_INIT_VALUE", $entry->etl_db_name() );

is( "new_value",     $entry->vp_variation_db("new_value") );
is( "new_etl_value", $entry->etl_db_name("new_etl_value") );

