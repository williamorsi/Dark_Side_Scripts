#!/usr/bin/perl -w
use strict;

####################################################
#
#  Declare global variables
#
#################################################
my $mothur_fasta = "MiSeq_stability_file.trim.contigs.good.fasta";            #FASTA file from mothur containing unique IDs for seqs
my $qiime_file = "qiime_formatted_fasta.fa";

my $fields_count = 0;
my @fields;

open (FASTA, $mothur_fasta) or die "Unable to open input file, $mothur_fasta";
open (OUT, ">$qiime_file") or die "Unable to open output file, $qiime_file";

while ( <FASTA>) {
    
    my $line = $_;
    chomp $line;
    my $seq;
    my $header;
    
    if ($line =~ m/(>\S+)/)
    {
        $header = $1;
    
    print OUT "$header", "\t";
    }
    
        if ($line =~ m/([T]\S+)/)
        
    {
        $seq = $1;
        print OUT "$seq", "\n";
    }
    
    
        
    }

close FASTA;
close OUT;

#so all you need to do is go to R project, download R 3.1.1 for mac os X 64 bit
#install
#update all of your libraries
#using biocLite()
#then run your code
#done