
use strict;
use Project::Pipeline::Config::Registry; 

use Test::More tests => 4; 

my $class = "Project::Pipeline::Config::Registry";  

my $registry = new_ok($class);  

$registry->add_manager("test_1" => "test_class_1"); 
$registry->add_manager("test_2" => "test_class_2"); 

is($registry->get_manager("test_1"), "test_class_1"); 
is($registry->get_manager("test_2"), "test_class_2"); 
is($registry->count_managers, 2); 


