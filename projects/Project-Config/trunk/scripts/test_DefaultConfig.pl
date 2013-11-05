
use strict;
use Project::Pipeline::Config;
use Project::Pipeline::Config::Entry;

#
# At first, the 'default' values out of the 'Config' are used for
# the initialization - this could be the 'auto-builder'  which uses a key :
#
my $default = Project::Pipeline::Config->new();

#
# We can overwrite the values explicity ( out of the default section of a config):
#
print "\n\n"; 
print "BASE CONFIG DEFAULT: " . $default->vp_variation_db() . "\n";
print "BASE CONFIG DEFAULT: " . $default->etl_db_name() . "\n";
print "\n\n"; 


my $entry = Project::Pipeline::Config::Entry->new();

# Overwritten in subclass
print "ENTRY INIT  DEFAULT: " . $entry->vp_variation_db() . "\n";
print "ENTRY INIT  DEFAULT: " . $entry->etl_db_name() . "\n";
print "\n\n"; 


$entry->default_class($default);

print "Setting default values: " . $entry->vp_variation_db() . "\n";
print "Setting default values: " . $entry->etl_db_name(). "\n";

# Set a new value out the config file:
$entry->vp_variation_db("MY NEW DEFAULT");

print "vp_variaton_db: " . $entry->vp_variation_db() . "\n";
print "vp_variaton_db: " . $entry->etl_db_name() . "\n";

#my $entry = Project::Pipeline::Config::Entry->new();
#$entry->traverse();

# A subclass does NOT get the attributes of a class instantiated at compile time.
# Default values are set during compile time.
#
# Maybe inheritance is the wrong concept.
#
# BASE class sets the default attributes ( the 'auto' builder ... )
# We crete the base class and overwrite the 'auto' defaults
# then we crete the DYN class and hand over     the created base class.
#
# We like to call:
#    new_class->vp_variation_db()
#
#    for every attribute:
#      - if no value is supplied, check the base class and return the value.
#    problem: names
#
#    BASE_CLASS->vp_variation_db = staatic valye
#    BASE_CLASS->vp_variation_db('dynamic value')
#
#    NEW_CLASS->vp_variation_db => should :
#                 return NEW_CLASS->vp_variation_db() if its defined
#                 return BASE_CLASS->vp_variation_db() if the value is not defined
#
#    There is a name class between the methods as I have the method name twice - in the 'has' definition and
#    the 'sub' definition.
#
#    Can I merge the 'sub' definition into the 'has' definition ?
#
#    AND: can I find a way to apply the default behaviour to ALL attributes ?
