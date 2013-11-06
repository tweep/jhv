
use strict;
use Project::Pipeline::Config;
use Project::Pipeline::Config::Entry; 

use Test::More tests => 4; 

my $class = "Project::Pipeline::Config::Entry";  

my $entry = new_ok($class);  

is("variation_db",$entry->vp_variation_db("variation_db"));
is("etl_db_name",$entry->etl_db_name("etl_db_name"));  

is(undef,$entry->output_dir(), "oko"); 



