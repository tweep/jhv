
use strict;
use warnings;

use Dist::Zilla::Tester;
use File::Temp qw( tempdir );
use Test::Most;

my $tempdir = tempdir( CLEANUP => 1 );
my $zilla = Dist::Zilla::Tester->from_config( { dist_root =>
                                                'corpus/autoversion_major', },
                                              { tempdir_root => $tempdir }
                                            );
my $plugin = $zilla->plugin_named('@GNE/AutoVersion');
is ($plugin->major, '42', 'Got the expected major version number');

done_testing();
