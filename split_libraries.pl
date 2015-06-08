#!/usr/bin/perl -w
use strict;



my $input_file = $ARGV[0];            #MiSeq file containing millions of sequences with barcodes in the headers

my $output_file = $ARGV[1];             #FASTA file with sequences only from one particular sample (i.e. TCCACAGGAGT)

my @sequences;
my $seq;
my $id;

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

local $/ = "\n@";

my $lookup = $ARGV[2];  # Sample ID to extract (i.e. TCCACAGGAGT)

while (my $seq = <INPUT>)

{
    chomp $seq;
    my ($id) = $seq =~ /MISEQ\S+(ACGACGTCTTA)/;  # parse barcode in header line
    if ($id eq $lookup) {
        push (@sequences, $seq); # make an array of sequences
    }
}

foreach my $sequences (@sequences){   # go through the array and print each sequence to the output file
    
    print OUT ">$sequences\n";
}

close INPUT;
close OUT;
