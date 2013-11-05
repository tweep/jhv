
use strict;
use Project::Pipeline::Config;
use Project::Pipeline::Config::Entry; 
use Test::Exception;
use Test::More tests => 10; 

my $default_config_class = "Project::Pipeline::Config";  

my $default = new_ok($default_config_class); 

# Set some default values: 
$default->vp_variation_db("default_vp_variation_db"); 
$default->etl_db_name("default_etl_db_name"); 
$default->output_dir(); 
 
# Create new Entry obj  

my $entry_class = "Project::Pipeline::Config::Entry";  

my $entry = new_ok($entry_class);  

$entry->traverse(); 

# If nothing is set, we should get the value from the DEFAULT class 
# We can either work with ROLES or with INHERITANCE
 
is("default_vp_variation_db", $entry->vp_variation_db());
$entry->vp_variation_db("vp_variation_db"); 
is("vp_variation_db", $entry->vp_variation_db()); 


is("default_etl_db_name", $entry->etl_db_name());
is("etl_db_name", $entry->etl_db_name("etl_db_name"));
is(undef, $entry->output_dir());
 


is("variation_db",$entry->vp_variation_db("variation_db"));
is("etl_db_name",$entry->etl_db_name("etl_db_name"));  

is(undef,$entry->output_dir(), "oko"); 



   # throws_ok {My::Base->new()} qr/Attribute \(attr\) is required/, q/base  requires 'attr' at construction/; 
   # 
   # my $base = new_ok('My::Base' => [attr => 'constructor value']); 
   # 
   # cmp_ok($base->attr, 'eq', "The value of attr is 'constructor value'", +'base is correct'); 
   # 
   # lives_ok {My::Derived->new()} q/derived doesn't require 'attr' at cons+truction/; 
   # 
   # my $der = new_ok('My::Derived'); 
   # 
   # cmp_ok($der->attr, 'eq', "The value of attr is 'default value'", 'derived is correct'); 

