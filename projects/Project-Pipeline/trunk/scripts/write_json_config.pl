#!/usr/local/bin/env perl 

use strict;
use warnings;

use Getopt::Long;
use Log::Log4perl qw(:easy);
use Log::Log4perl::CommandLine qw(:all);
use Log::Log4perl::CommandLine ':all', ':loginit' => { level => $WARN };
use autodie;
use JSON;

#
# Below an example config which we dump to json:
#

my $tmp = {
    "Project::Registry::Manager::Config::Database" => {
        DEFAULT => {
            "host" => "json_test01",
            "user" => "json_myuser",
            "pass" => "json_password",
            "port" => "json_9306",
        },
        dataset => {
            "cgi_wgs" => {
                "dbname" => "SPECIAL_my_db_name",
                "group"  => "SPECIAL_group",
                "host"   => "SPECIAL_test01",
                "user"   => "SPECIAL_myuser",
                "pass"   => "SPECIAL_password",
                "port"   => "SPECIAL_9306",
            },
            "tcga_07" => {
                "group" => "TCGA_group",
            },

        }
    },
    "Project::Registry::Manager::Config::Dataset" => {
        DEFAULT => {
            "base_dir"             => "OK_json_base_dir",
            "ensembl_cvs_root_dir" => "OK_ENS_CVS_",
        },
        dataset => {
            "cgp3" => {
                vp_variation_db => "vogelj4_evar_2013_03_03_cgp3",
                etl_db_name     => "vogelj4_evar_2013_09_01_cgp3_etl",
                json_vcf_file =>
"/gne/research/workspace/vogelj4/projects/gmvp/import_data_2013_06_24_cgp3/json_strings/json_reformat.txt",
                variant_caller => "gneCaller.1", 
                merge_set_name => "cgp",

           #xml_dump_dir    => "/path/to/alternative_dir_with_dumped_xml_files",
            },
            "cgp4" => {
                vp_variation_db => "vogelj4_evar_2013_09_01_cgp4",
                etl_db_name     => "vogelj4_evar_2013_09_01_cgp4_etl",
                json_vcf_file =>
"/gne/research/workspace/vogelj4/projects/gmvp/import_data_2013_09_01_cgp4/json_strings/json_vcf_file_loc_reformat.txt",
                variant_caller  => "gGATK",
                merge_set_name => "cgp",
                dump_merge_info => {
                    dump_to_xml =>
                      0,  # Flag if the data set should be dumped from db to XML
                    annotate_xml => 0,  # add meta-data to dumped XML
                    merge_data   => 1,  # Flag if you want to merge the XML data
                    merge_set_name => "cgp"
                    , # Name of the merge set. Data with the same "merge_set_name" will be merged together (tcga_06 and tcga_07)...
                    upload_to_solr =>
                      0,    # Flag if you want to merge the XML data
                },
            },

        },
    },
    "Project::Registry::Manager::Config::AnnotateXML" => {

        DEFAULT => {
            key_field_delimiter => "-",
        },

        dataset => {

            #
            # Sample meta data - writes "sample_*" fields
            #

            "sample" => {
                xml_key_field => ['sample_samplehub_sample_id'],
                annotation_module =>
                  ['GNE::VariationPortal::Adaptor::SampleInfoAdaptor'],
            },

            #
            # Xref annotation - writes ""
            #

            "xref" => {
                xml_key_field => [
                    'vf_seq_region_name', 'vf_seq_region_start',
                    'vf_seq_region_end',  'allele_string'
                ],
                annotation_module =>
                  ['GNE::VariationPortal::Adaptor::XrefAdaptor'],
            },

            #
            # Condel annotation - writes "condel_score"
            #

            "condel" => {
                xml_key_field => [ 'hgvs_genomic', 'tr_transcript_stable_id' ],
                annotation_module =>
                  ['GNE::VariationPortal::Adaptor::CondelAdaptor'],
            },

 #
 # SSV annotation - writes "paired_sample" and "al_ssv_allele_comparison_sam_id"
 #

            "ssv" => {
                xml_key_field =>
                  [ 'vf_seq_region_name', 'vf_seq_region_start' ],
                annotation_module => [
'GNE::VariationPortal::Adaptor::SampleSpecificVariationAdaptor'
                ],
            },

#
# DataSet annotation - global annotation for all values in a data set
#                      Writes "al_ssv_allele_comparison_sam_id" and "paired_sample" for TCGA data as TCGA data has no SSV file
#                      (it's ALL SSV data)
#

            "data_set" => {
                xml_key_field => ['sample_samplehub_sample_id'],
                annotation_module =>
                  ['GNE::VariationPortal::Adaptor::DataSetAdaptor'],
            },

            #
            # MAF annotation
            #

#                                                      "maf"  => #{
#                                                                    xml_key_field       => ['sample_samplehub_sample_id' ],
#                                                                    annotation_module   => [ 'GNE::VariationPortal::Adaptor::SampleSpecificVariationAdaptor' ],
#  }

        }
     }
    };

      open( FP, ">", "test.json" ) || die "cant write to file\n";

      my $json_text = to_json( $tmp, { utf8 => 1, pretty => 1 } );
      print $json_text. "\n";
      print FP $json_text . "\n";
      close(FP);

## Please see file perltidy.ERR
