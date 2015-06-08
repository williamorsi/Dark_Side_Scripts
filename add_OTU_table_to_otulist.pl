#!/usr/bin/perl -w
#This script will take PhymmBL output (tab delimited) and merge the taxonomic annotations with functional annotations (e.g. COG, Pfam) as produced by the RAMMCAP pipeline (through CAMERA website).  The script is currently setup to work with contigs made with CLC genomics workbench, so the regex matching the header must be changed to match the unique header for each dataset
use strict;



my $contigs_input = "all_best_looking_heavy_otu_list.txt";
my $taxon_input = "otu_table_97_withtaxonomy.txt";

my $output_file = "all_best_looking_heavy_OTUTABLE_not_rarified.txt";

my %hash_table;
my $hash_count = 0;
my $cogs_count = 0;

print "\nProgram started ............\n";

open (CONTIGS, $contigs_input) or die "Unable to open contig/reads input file, $contigs_input";
open (TAXON, $taxon_input) or die "Unable to open taxonomy input file, $taxon_input";

open (OUTPUT, ">$output_file") or die "Unable to open output file, $output_file";

print "Input and Output Files were successfully opened ......\n";

$/ = "\r";

while ( <TAXON> )
{
    my $line = $_;
    
    $line =~ s/\r//;
    
    my @fields = split (/\t/, $line);
    
    if ($fields[0] =~ m/(denovo\d*)/)
    {
        my $list = "";
        for (my $i = 1; $i <= $#fields; $i++)
        {
            $list = $list . $fields[$i] . ";"
        }
        
        $hash_table{$1} = $list;
        $hash_count++;
    }
}

$/ = "\n";

print "Hash-table of $hash_count taxonomy records created .......\n";

print OUTPUT "OTU\tCL1\tCL2\tCL3\tCL4\tCL5\tCL6\tCL7\tCL8\tCL9\tCL10\tCL11\tCL1\tCL13\tCL14\tCL15\tCM1\tCM2\tCM3\tCM4\tCM5\tCM6\tCM7\tCM8\tCM9\tCM10\tCM11\tCM12\tCM13\tCM14\tCM15\tCS1\tCS2\tCS3\tCS4\tCS5\tCS6\tCS7\tCS8\tCS9\tCS10\tCS11\tCS12\tCS13\tCS14\tCS15\tSL1\tSL2\tSL3\tSL4\tSL5\tSL6\tSL7\tSL8\tSL9\tSL10\tSL11\tSL12\tSL13\tSL14\tSL15\tSM1\tSM2\tSM3\tSM4\tSM5\tSM6\tSM7\tSM8\tSM9\tSM10\tSM11\tSM12\tSM13\tSM14\tSM15\tSS1\tSS2\tSS3\tSS4\tSS5\tSS6\tSS7\tSS8\tSS9\tSS10\tSS11\tSS12\tSS13\tSS14\tSS15\n";

while ( <CONTIGS> )
{
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    my $reads = 0;
    if ($fields[0] =~ m/(denovo\d*)/)
        {
            my $contig = $1;
            my $taxon = " - ";
            
            for (my $i = 0; $i <= $#fields; $i++)
            {
                print OUTPUT "$fields[$i]", "\t";
            }
            
            if ($hash_table{$contig})
            {
                $taxon = $hash_table{$contig};
                my @taxa = split (/;/, $taxon);
                for (my $i = 0; $i <= $#taxa; $i++)
                {
                    print OUTPUT "$taxa[$i]", "\t"; 
                }
            }
            
            print OUTPUT "\n";
            $cogs_count++;
        }
}

print "Output file, $output_file, created with $cogs_count entries...........\n";

close TAXON;
close CONTIGS;
close OUTPUT;

print "\nProgram Complete ..............\n";

