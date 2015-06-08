#!/usr/bin/perl -w
use strict;

##################################################
#
# Specify input and output file names here; open files
#
###################################################


my $input_file = "642_blastx.txt";
my $output_file = "642_blastx_counted_ge_30_id.txt";


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
#  Read through input file; maintain list of genes and their aa ids in hash table
#
######################################################


my %gene_hash;
#my $total_reads;

while ( <INPUT> )
{
    my $line = $_;
    
    chomp $line;
    
    my @fields = split (/\t/, $line);

    if ( $fields[2] ge (30) )      # If the gene has an aa id >60%
    {
	if  (  $gene_hash{$fields[1]}  )
{
            $gene_hash{$fields[1]}++;           # increment the count for the gene
        }
        else
        {
        	$gene_hash{$fields[1]} = 1;         # otherwise, set the count to 1
        }
}
}


## foreach my $key ( sort keys %gene_hash )     # count the total number of sequences that have blast id >60
##
##{
##	$total_reads += $gene_hash{$key};
##}


#####################################################
#
#  Print out list of genes and their reads
#
######################################################

foreach my $key ( sort keys %gene_hash )
{

      my $percent = ($gene_hash{$key} / 5248980) * 100;     #percent of reads in entire metagenome, chage the denomiator for each dataset

    print OUT "$key", "\t", "$gene_hash{$key}", "\t", "$percent", "\t", "\n";
}

close INPUT;
close OUT;

    
