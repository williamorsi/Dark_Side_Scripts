#!/usr/bin/perl -w
use strict;

####################################################
#
#  Declare global variables
#
#################################################
my $qiime_df = "qiime_formatted_dataframe.txt";
my $qiime_fasta = "qiime_formatted_fasta.fa";

my $fields_count = 0;
my @fields;

open (DF, $qiime_df) or die "Unable to open input file, $qiime_df";
open (OUT, ">$qiime_fasta") or die "Unable to open output file, $qiime_fasta";

while ( <DF>) {
    
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    
    if ($fields[0] =~ m/(\S+)/)
    
    {

    print OUT ">$fields[0]", "\n", "$fields[1]", "\n";
    
    }
}

close DF;
close OUT;

#so all you need to do is go to R project, download R 3.1.1 for mac os X 64 bit
#install
#update all of your libraries
#using biocLite()
#then run your code
#done