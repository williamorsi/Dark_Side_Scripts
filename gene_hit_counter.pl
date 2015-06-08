#!/usr/bin/perl -w
use strict;

##################################################
#
# Specify input and output file names here; open files
#
###################################################


my $input_file = "filled_draft_matrix.txt";  # this is the output from fill_matrix.pl
my $output_file = "genes_counted.txt";


open (INPUT, $input_file) or die "Unable to open input file, $input_file";
open (OUT, ">$output_file") or die "Unable to open output file, $output_file";


my %gene_hash;


while ( <INPUT> )  # read through the input file
{
    my $line = $_;
    
    chomp $line;                          #remove all newline (\n) characters from $line
    
    my @fields = split (/\t/, $line);     #split on tabs & make an array out of $line
    
    my $sample = $fields[0];
    
    
    if ( $gene_hash{$sample})
    {
        $gene_hash{$sample}++;          # increment the count (the value)
    }
    else
    {
        $gene_hash{$sample} = 1;       # create it and give it a value (count) of 1
    }
}

foreach my $key (sort keys %gene_hash)   # read through outer keys of hash table
{
    {
        print OUT "$key\t", "$gene_hash{$key}" , "\n";              #print keys and count
    }
}


close INPUT;
close OUT;

print "\n\n\nNow take the first column from genes_counted.txt, and copy paste it over the first column in the 'row summed' matrix from R, this will be the final matrix\n\n\n";