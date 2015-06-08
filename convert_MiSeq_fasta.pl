#!/usr/bin/perl -w
use strict;

###############################################################################################################################
#  This script was created by William D. Orsi (william.orsi@gmail.com).  If you use this script please cite Orsi et al. 2014  #
###############################################################################################################################

my $miseq_input = "ACGACGTCTTA.fa";

my $output_file = "C0912_C49A8_15.fa";
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
    
    $lines[0] =~ s/(MISEQ\d+\S\d+\S\d+\SA4BBH)/>C0912_C49A8_15/g;
    
    $lines[0] =~ s/(\SACGACGTCTTA)//g;
    
    $lines[0] =~ s/(\S+[?;E.FH]\S+)//g;
    
    $lines[0] =~ s/\+//g;
    
    $lines[0] =~ s/\>@//g;
    
    $lines[0] =~ s/\>>/>/g;
    
    print OUT "$lines[0]\n";
}


close MISEQ;
close OUT;

