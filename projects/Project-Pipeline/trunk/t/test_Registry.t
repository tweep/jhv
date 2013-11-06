
use strict;
use Project::Registry;
use Project::Registry::Manager;

use Test::More tests => 4; 

my $class = "Project::Registry";  

my $registry = new_ok($class);

$registry->add_manager("Dataset"  => Project::Registry::Manager->new()); 
$registry->add_manager("Database" => Project::Registry::Manager->new()); 

is(ref($registry->get_manager("Dataset")), "Project::Registry::Manager","returns correct class"); 
is(ref($registry->get_manager("Database")), "Project::Registry::Manager","returns correct class"); 
is($registry->count_managers, 2,"number of registered managers correct"); 


