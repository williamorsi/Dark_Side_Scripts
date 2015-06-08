#!/usr/bin/perl -w
use strict;

##################################################
#
# Specify input and output file names here; open files
#
###################################################


my $input_file = "0.1_0.8_3_blastx_counted_combined_counter_input.txt";
my $output_file = "0.1_0.8_3_blastx_counted_combined_counted.txt";


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
    
    my $reads_count = "0";
    
    
    if ($fields[1] =~ m{\d+})
    {
        $reads_count = $fields[1];
    }

	my $gene;
	my $gene = $fields[0];
     
    if ( $fields[0] =~ m/(MG2_\d*)/ )
    {
         $gene_hash{$gene} += $reads_count;
        }
        else
        {
            $gene_hash{$gene} = $reads_count;
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

    
