
use strict;
use Project::Registry::Manager; 

use Test::More tests => 4; 

my $registry = new_ok("Project::Registry::Manager");  

$registry->add_config("test_1" => "test_class_1"); 
$registry->add_config("test_2" => "test_class_2"); 

is($registry->get_config("test_1"), "test_class_1"); 
is($registry->get_config("test_2"), "test_class_2"); 
is($registry->count_configs, 2); 


