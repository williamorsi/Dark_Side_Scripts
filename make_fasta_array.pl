#!/usr/bin/perl -w
use strict;



my $fasta_file = "MGII_sequences.fa";
my $array_fasta = "MGII_arrayed_sequences.txt";


open (FASTA, "$fasta_file") or die "Unable to open output file, $fasta_file";
open (ARRAY, ">$array_fasta") or die "Unable to open taxonomy input file, $array_fasta";

while ( <FASTA>)

{
    my $line = $_;
    chomp $line;
    my @lines = split (/"\n>"/, $line);
    
    if ($lines[0] =~ m/([ATCG]{2,})/)
    {
    print ARRAY "$1", "\n";
    }
    }
    

close FASTA;
close ARRAY;


print "\nProgram Complete ..............\n";

