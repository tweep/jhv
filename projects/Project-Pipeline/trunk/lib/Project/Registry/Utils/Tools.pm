
package Project::Registry::Utils::Tools;

use strict;
use warnings;

use Log::Log4perl qw(:easy);
use Exporter;
use JSON;
use LWP::Simple;
use Module::Load;

use vars qw(@ISA @EXPORT);
@ISA    = qw(Exporter);
@EXPORT = qw(
  read_json_file
  merge_config_sections
  create_default_config_section_obj
);



=head2 

Arg [1]    : create_default_config_section_obj
Example    : create_default_config_section_obj(GNE
Description: 
Returntype : 
Exceptions : 

=cut

sub create_default_config_section_obj {
    my ( $module_name, $config ) = @_;

    load $module_name;    # load Project::Registry::Manager::Config::Database

    if ( exists $config->{DEFAULT} ) {
        return $module_name->new( $config->{DEFAULT} );
    }
    return $module_name->new();
}


sub merge_config_sections {
    my ( $default, $specialized ) = @_;

    my %merged_config;

    my %tmp = ( %$default, %$specialized );

    for my $config_key ( keys %tmp ) {
        if ( !defined $specialized->{$config_key} ) {
            INFO( "Using JSON DEFAULT: $config_key => $default->{$config_key}");
            $merged_config{$config_key} = $default->{$config_key};
        }
        else {
            INFO("JSON SPECIAL: $config_key => $specialized->{$config_key}");
            $merged_config{$config_key} = $specialized->{$config_key};
        }
    }
    return \%merged_config;
}

=head2 read_json_file()

Arg [1]    : String describing file name 
Example    : my $data = read_json_file("/path/to/file.json"); 
Description: Reads a JSON file and returns the data structure 
Returntype :  
Exceptions : 

=cut

sub read_json_file {
    my ($js_file) = @_;

    INFO( "Reading JSON file: " . $js_file );

    if ( !-e $js_file || !-r $js_file ) {
        die("JSON file does not exist or is not readable: $js_file");
    }

    my $jstring;
    {
        local $/;    #enable slurp
        open my $fh, "<", $js_file || die("Can't read JSON file: $js_file");
        $jstring = <$fh>;
    }
    my $js_string = JSON->new->allow_nonref->decode($jstring);
    return $js_string;
}

1;

