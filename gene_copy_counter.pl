#!/usr/bin/perl -w
use strict;

##################################################
#
# Specify input and output file names here; open files
#
###################################################


my $input_file = $ARGV[0];
my $output_file = $ARGV[1];


open (INPUT, $input_file) or die "Unable to open input file, $input_file";
open (OUT, ">$output_file") or die "Unable to open output file, $output_file";
 

#####################################################
#
#  Test for line feed character used in input file ( \r or \n )
#
######################################################



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


#####################################################
#
#  Read through input file; maintain list of contigs/reads in hash table
#
######################################################


my %gene_hash;


while ( <INPUT> )
{
    my $line = $_;
    
    chomp $line;
    
    my @fields = split (/\t/, $line);
     
    if ( $fields[0] =~ m/(\S+[DRAFT_]\d+)/ )
    {
         if ( $gene_hash{$1} )          # If the gene exists ...
        {
            $gene_hash{$1}++;           # increment the count for the gene
        }
        else
        {
        	$gene_hash{$1} = 1;         # otherwise, set the count to 1
        }
    }
}


#####################################################
#
#  Print out list of genes and their reads
#
######################################################

foreach my $key ( sort keys %gene_hash )
{
    print OUT "$key", "\t", $gene_hash{$key}, "\n";
}

close INPUT;
close OUT;

    
