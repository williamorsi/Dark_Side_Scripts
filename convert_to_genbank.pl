#!/usr/bin/perl -w
use strict;

my $seq_input = "MGII.fasta";

my $output_file = "MGII_genbank_formated.fasta";
my $line;
my @lines;
my $lines;
my $counter = 1;

print "\nProgram started ............\n";

open (SEQ, $seq_input) or die "Unable to open reads input file, $seq_input";

open (OUT, ">$output_file") or die "Unable to open output file, $output_file";

#########
# Read through the miseq file, replace header with sample ID (maintaining seq IDs),remove barcode sequence, remove quality scores line, remove plus signs, remove duplicate carats
########


    while ( <SEQ>)
{
    my $line = $_;
    chomp $line;
    my @lines = split (/"\n>"/, $line);
    
    $lines[0] =~ s/(_)/\_$counter\_/;
   
    $counter++;
    
    print OUT "$lines[0]\n";
    
}


close SEQ;
close OUT;

