#!/usr/bin/perl -w
use strict;



my $gene_counts_input = $ARGV[0];

my $genome_gene_list = $ARGV[1];

my $output_file = $ARGV[2];

my %hash_table;
my $hash_count = 0;
my $gene_count = 0;

print "\nProgram started ............\n";

open (GENECOUNTS, $gene_counts_input) or die "Unable to open counts input file, $gene_counts_input";
open (GENOMEGENELIST, $genome_gene_list) or die "Unable to open genome gene list input file, $genome_gene_list";

open (OUTPUT, ">$output_file") or die "Unable to open output file, $output_file";

print "Input and Output Files were successfully opened ......\n";

close GENOMEGENELIST;
open (GENOMEGENELIST, $genome_gene_list) or die "Unable to open input file, $genome_gene_list";


#####################################################
#
#  Read through input file; maintain list of contigs/reads in hash table
#
######################################################

while ( <GENECOUNTS> )
{
    my $line = $_;
    my @fields = split (/\t/, $line);
    if ($fields[0] =~ m/(\d+)/)
    {
        $hash_table{$fields[1]} = $fields[11];
        
        $hash_count++;
    }
}

print "Hash-table of $hash_count gene counts created .......\n";

while ( <GENOMEGENELIST> )
{
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    if ($fields[0] =~ m/(\d+)/)
        {
            my $gene = $1;
            my $reads = $hash_table{$gene};
            print OUTPUT "$fields[0]\t", "$reads\n";
            $gene_count++;
        }
}

print "Output file, $output_file, created with $gene_count entries...........\n";

close GENECOUNTS;
close GENOMEGENELIST;
close OUTPUT;

print "\nProgram Complete ..............\n";
