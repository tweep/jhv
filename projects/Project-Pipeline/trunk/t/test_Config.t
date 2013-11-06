
use strict;
use Project::Pipeline::Config;
use Project::Pipeline::Config::Entry; 
use Test::Exception;
use Test::More tests => 5; 

my $default_config_class = "Project::Pipeline::Config";  

my $default = new_ok($default_config_class); 

# Check the default values:  
is("CONFIG_VPP_INIT_VALUE",$default->vp_variation_db());
is("CONFIG_ETL_INIT_VALUE",$default->etl_db_name());


$default->vp_variation_db("new_vp_variation_db"); 
$default->etl_db_name("new_etl_db_name");  

is("new_vp_variation_db",$default->vp_variation_db());
is("new_etl_db_name",$default->etl_db_name());
 

