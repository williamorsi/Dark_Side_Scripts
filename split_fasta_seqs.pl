#!/usr/bin/perl -w
use strict;

####################################################
#
#  Declare global variables
#
#####################################################

my $input_file = $ARGV[0];            #FASTA file from CAMERA containing sequences from many different samples with different headers
my $output_file = $ARGV[1];             #FASTA file with sequences only from one particular sample (i.e. CAM_S_641)

my @sequences;

open (INPUT, $input_file) or die "Unable to open input file, $input_file";

while ( <INPUT> )
{
    my $line = $_;
    
    if ($line =~ /\r/)
    {
        $/ = "\r";
    }
    
    elsif ($line =~ /\n/)
    {
        $/ = "\n";        
    }
    
    last;
}


close INPUT;
open (INPUT, $input_file) or die "Unable to open input file, $input_file";
open (OUT, ">$output_file") or die "Unable to open output file, $output_file";


my $lookup = $ARGV[2];  # Sample ID to extract (i.e. CAM_S_641)

local $/ = "\n>";  # read by FASTA record

while (my $seq = <>) {
    chomp $seq;
    my ($id) = $seq =~ /sample_id="(CAM_S_\d+)"/;  # parse sample ID in FASTA header 
    if ($id eq $lookup) {
       push (@sequences, $seq); # make an array of sequences
    }
}

foreach my $sequences (@sequences){   # go through the array and print each sequence to the output file

print OUT ">$sequences\n";
}