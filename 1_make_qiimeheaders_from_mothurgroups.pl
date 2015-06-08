#!/usr/bin/perl -w
use strict;

####################################################
#
#  Declare global variables
#
#################################################
my $mothur_groups = "MiSeq_stability_file.contigs.good.groups";             #tab delimited file from mothur containing the sample for each seq
my $qiime_groups = "qiime_formatted_headers.txt";

my @sequences;
my $seq;
my %hash_table;
my $hash_sequence;
my $hash_count = 0;

open (GROUPS, $mothur_groups) or die "Unable to open input file, $mothur_groups";
open (OUT, ">$qiime_groups") or die "Unable to open output file, $qiime_groups";

while ( <GROUPS> )
{
    my $line = $_;
    chomp $line;
    my $hash_sequence;
    my @fields = split (/\t/, $line);
    
    if ($fields[0] =~ m/\S+/)
        
    {
        
        print OUT "$fields[0]", "\t", "$fields[1]", "_", "$fields[0]", "\n";
        
    }
}

close GROUPS;
close OUT;

#so all you need to do is go to R project, download R 3.1.1 for mac os X 64 bit
#install
#update all of your libraries
#using biocLite()
#then run your code
#done