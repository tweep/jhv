
use strict;
use Project::Registry::Manager::Config;
use Test::More tests => 3; 

my $default = new_ok("Project::Registry::Manager::Config");

# Check the default values:  
is("Homo sapiens",$default->species());

is("new_species",$default->species("new_species"));
 

