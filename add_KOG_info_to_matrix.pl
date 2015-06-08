#!/usr/bin/perl -w
#This script will take PhymmBL output (tab delimited) and merge the taxonomic annotations with functional annotations (e.g. COG, Pfam) as produced by the RAMMCAP pipeline (through CAMERA website).  The script is currently setup to work with contigs made with CLC genomics workbench, so the regex matching the header must be changed to match the unique header for each dataset
use strict;



my $contigs_input = "Cryvi1_GeneCatalog_proteins_20130104_KOG.txt";
my $taxon_input = "KW_test_normalized<0.05.txt";

my $output_file = "KW_test_<0.05_with_genome_info.txt";

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
    
    if ($fields[0] =~ m/(\d+)/)
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

print OUTPUT "#proteinID\tER_19\tER_20\tER_21\tER_22\tER_24\tER_28\tER_29\tER_30\tER_32\tER_33\tER_34\tER_35\tER_36\tPM5\tPM30\tPM50\tPM70\tPM91\tPM159\tav_pm\tav_rhizo\tpm:rhizo\n";

while ( <CONTIGS> )
{
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    my $reads = 0;
    if ($fields[0] =~ m/(\d+)/)
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

