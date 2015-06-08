#!/usr/bin/perl -w
use strict;



my $otu_list = "MGII_OTU_list.txt";
my $otu_map = "all_C0912_samples_otus.txt";
my $output_file = "MGII_all_sequences_list.txt";
my %hash_table;
my $hash_count = 0;
my $otu_count = 0;
my $taxon;

print "\nProgram started ............\n";

open (OTUS, $otu_list) or die "Unable to open contig/reads input file, $otu_list";
open (MAP, $otu_map) or die "Unable to open taxonomy input file, $otu_map";

open (OUTPUT, ">$output_file") or die "Unable to open output file, $output_file";

print "Input and Output Files were successfully opened ......\n";

while ( <MAP> )
{
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    if ($fields[0] =~ m/(\d+)/)
    {
    
        $hash_table{$1} = $line;
        $otu_count++;
    }
}

print "Hash-table of $otu_count OTU records created .......\n";

while ( <OTUS> )
{
    my $line = $_;
    chomp $line;
    
    my @fields = split (/\t/, $line);
    my $headers;
    
    if ($fields[0] =~ m/(\d+)/)
    {
        
        my $gene = $1;
        my $headers = $hash_table{$gene};
        print OUTPUT "$headers", "\n";
        $hash_count++;
    }
}

print "Output file, $output_file, created with $hash_count sequence header entries...........\n";

close OTUS;
close MAP;
close OUTPUT;


print "\nProgram Complete ..............\n";

