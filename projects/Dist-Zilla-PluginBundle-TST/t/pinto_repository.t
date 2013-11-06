
use strict;
use warnings;

use Dist::Zilla::Tester;
use File::Temp qw( tempdir );
use Test::Most;

my $tempdir = tempdir( CLEANUP => 1 );
my $zilla = Dist::Zilla::Tester->from_config( { dist_root =>
                                                'corpus/basic', },
                                              { tempdir_root => $tempdir },
                                            );
my $plugin = $zilla->plugin_named('@GNE/Pinto::Add');
is ($plugin->repos, 'http://gpan.gene.com:3000', 'Got the default pinto repository');

$zilla = Dist::Zilla::Tester->from_config( { dist_root =>
                                             'corpus/pinto_repository', },
                                           { tempdir_root => $tempdir }
                                         );
$plugin = $zilla->plugin_named('@GNE/Pinto::Add');
is ($plugin->repos, 'http://gpan.X.Ample.org:4242', 'Got the customized pinto repository');

done_testing();
