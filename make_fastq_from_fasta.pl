#!/usr/bin/perl -w
use strict;



my $fasta = "MGII_arrayed_sequences.txt";
my $fastq = "standard-1_original.fastq";
my $output = "MGII_sequences.fastq";
my %hash;
my $name = "CCC";
my $sequence;

open (FASTA, "$fasta") or die "Unable to open fasta input file, $fasta";
open (FASTQ, "$fastq") or die "Unable to open fastq input file, $fastq";
open (OUTPUT, ">$output") or die "Unable to open output file, $output";

while ( <FASTA>)

{
    my $line = $_;
    
    chomp $line;
    my @MGII_array = split (/\t/, $line);
    
    if ($line =~ m/.+/)
        
    {
        $sequence=$MGII_array[0];
        
        $hash{$sequence} = $name;
    }
    
}

while ( <FASTQ> )

{
    my $line = $_;
    chomp $line;
    my @lines = split (/"\n@"/, $line);
    
    if ($lines[0] =~ m/.+([ATGC]{15,}).+/)
        
    {
        my $MGII_fastq = $1;
        
    }
    
    elsif   (my $MGII_fastq = $hash{$sequence})
    
    {
        
        print OUTPUT "$lines[0]", "\n";
        
    }
    
}

close FASTA;
close FASTQ;
close OUTPUT;


print "\nProgram Complete ..............\n";

