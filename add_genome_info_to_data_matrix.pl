#!/usr/bin/perl -w
#This script will take PhymmBL output (tab delimited) and merge the taxonomic annotations with functional annotations (e.g. COG, Pfam) as produced by the RAMMCAP pipeline (through CAMERA website).  The script is currently setup to work with contigs made with CLC genomics workbench, so the regex matching the header must be changed to match the unique header for each dataset
use strict;



my $gene_matrix = $ARGV[0];
my $genome_info = $ARGV[1];

my $output_file = $ARGV[2];

my %hash_table;
my $hash_count = 0;
my $cogs_count = 0;

print "\nProgram started ............\n";

open (MATRIX, $gene_matrix) or die "Unable to open contig/reads input file, $gene_matrix";
open (GENOME, $genome_info) or die "Unable to open taxonomy input file, $genome_info";

open (OUTPUT, ">$output_file") or die "Unable to open output file, $output_file";

print "Input and Output Files were successfully opened ......\n";

$/ = "\r";

while ( <GENOME> )
{
    my $line = $_;
    
    $line =~ s/\r//;
    
    my @fields = split (/\t/, $line);
    
    if ($fields[1] =~ m/\S+[DRAFT_]\d+/ and $fields[2] =~ m/Coordinates/)
    {
        
        $hash_table{$fields[1]} = $fields[4];
        $hash_count++;
    }
}

$/ = "\n";

print "Hash-table of $hash_count genome records created .......\n";

my $annotations_count = 0;

while ( <MATRIX> )
{
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    my $reads;
    
    if ($fields[0] =~ m/(\S+[DRAFT_]\d+)/)
    {
        my $gene = $1;
        my $reads = $hash_table{$gene};
        print OUTPUT "$reads", "\n";
        $annotations_count++;
    }
}


print "Output file, $output_file, created with $annotations_count entries...........\n";

close TAXON;
close CONTIGS;
close OUTPUT;

print "\nProgram Complete ..............\n";

