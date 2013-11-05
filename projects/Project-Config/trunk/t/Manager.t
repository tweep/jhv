
use strict;
use Project::Pipeline::Config::Manager; 

use Test::More tests => 4; 

my $class = "Project::Pipeline::Config::Manager";  

my $registry = new_ok($class);  

$registry->add_config("test_1" => "test_class_1"); 
$registry->add_config("test_2" => "test_class_2"); 

is($registry->get_config("test_1"), "test_class_1"); 
is($registry->get_config("test_2"), "test_class_2"); 
is($registry->count_configs, 2); 


