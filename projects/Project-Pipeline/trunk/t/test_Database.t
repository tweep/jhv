
use strict;
use Project::Registry::Manager::Config::Database;
use Test::Exception;
use Test::More tests => 3;


my $db = new_ok("Project::Registry::Manager::Config::Database"); 

is("resio01",$db->host(),"host");   
is("abc",$db->host("abc"),"host");  

   # $default->vp_variation_db("new_vp_variation_db");
   # $default->etl_db_name("new_etl_db_name");
   # 
   # #
   # # Create new Entry obj
   # # 
   # 
   # 
   # my $entry = new_ok("Project::Registry::Config::Entry");
   # 
   # # Both  Project::Registry::Config and  Project::Registry::Config::Entry
   # # consume the ROLE : Project::Registry::Role::Config
   # 
   # #
   # # The initial/default values are set by the _build_* methods in
   # # Project::Registry::Config and Project::Registry::Config::Entry
   # #
   # 
   # is( "ENTRY_VPP_INIT_VALUE", $entry->vp_variation_db() );
   # is( "ENTRY_ETL_INIT_VALUE", $entry->etl_db_name() );
   # 
   # is( "new_value",     $entry->vp_variation_db("new_value") );
   # is( "new_etl_value", $entry->etl_db_name("new_etl_value") );
   # 
