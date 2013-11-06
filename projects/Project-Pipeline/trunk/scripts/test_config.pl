#!/usr/local/bin/env perl 

use strict;
use warnings;

use Getopt::Long;
use Log::Log4perl qw(:easy);
use Log::Log4perl::CommandLine ':all', ':loginit' => { level => $WARN };
use autodie;
use JSON;
use Data::Dumper;
use Project::Registry::Utils::Tools; 

use Project::Registry;
use Project::Registry::Manager;

my $file = "test.json";

&GetOptions( 'config=s' => \$file, );


if (! -e $file ) {   
  die("The config file you specified does not exist\n"); 
} 

my $js     = read_json_file($file);

my $registry = Project::Registry->new(); 
$registry->setup_config($js); 

# We could write Adaptors to create a Project::Recgistry from different sources, like: 
# JSON, MySQL 
# For now, we can play around with this and maybe add to the CommandBase || Pipeline files: 
# Read a JSON file and return a HashRef  
#
# my $config = Project::Registry::Adaptor::JSON->new("file" => "/path/to/text.json" );
# Project::Registry->new($config); 
#  
# Later : my $registry =  Project::Registry->easy_init( {"adaptor" => "Project::Registry::Adaptor::JSON",  "json" => "/path/to/file.json" } );  
#         my $registry =  Project::Registry->easy_init( {"adaptor" => "Project::Registry::Adaptor::MySQL", "uri" => "mysql::gne::***:9306::dbname"  } );  

print Dumper($registry);

# Now work with the registry to replace all methods which we use the VP code. 
# The RunnableDB should get a --config attribute to accept 
# Create the Registry object ? In Pipeline::** in App::Command::**  
#
# -a dd a registry option to RunnableDB so it can get passed into the runnable 
#
# 


