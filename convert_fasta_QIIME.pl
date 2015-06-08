#!/usr/bin/perl -w
use strict;

my $miseq_input = "all_C0912_samples.fa";

my $output_file = "all_C0912_samples_QIIME_formatted.fa";
my $line;
my @lines;
my $lines;

print "\nProgram started ............\n";

open (MISEQ, $miseq_input) or die "Unable to open reads input file, $miseq_input";

open (OUT, ">$output_file") or die "Unable to open output file, $output_file";

#########
# Read through the miseq file, replace header with sample ID (maintaining seq IDs),remove barcode sequence, remove quality scores line, remove plus signs, remove duplicate carats
########


    while ( <MISEQ>)
{
    my $line = $_;
    chomp $line;
    my @lines = split (/"\n@"/, $line);
    
    $lines[0] =~ s/(C0912_)\S+//g;
    
    print OUT "$lines[0]\n";
}


close MISEQ;
close OUT;

