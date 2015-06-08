#!/usr/bin/perl -w
use strict;

##################################################
#
# Specify input and output file names here; open files
#
###################################################


my $input_file = $ARGV[0];  # this is the concatenated BLASTx output (m8)
my $output_file = "BLASTx_counted.txt";


open (INPUT, $input_file) or die "Unable to open input file, $input_file";
open (OUT, ">$output_file") or die "Unable to open output file, $output_file";


my %gene_hash;


while ( <INPUT> )  # read through the input file
{
    my $line = $_;
    
    chomp $line;                          #remove all newline (\n) characters from $line
    
    my @fields = split (/\t/, $line);     #split on tabs & make an array out of $line
    
    my $sample = $fields[0];
    
    my $gene = $fields[2];                 # pull gene from second column
    
    if ( $gene_hash{$gene}{$sample} and $fields[3] ge 59)         # if sample-gene combination exists and has greater than 59% homology
    {
        $gene_hash{$gene}{$sample}++;          # increment the count (the value)
    }
    else                                      # if it doesn't exits
    {
        $gene_hash{$gene}{$sample} = 1;       # create it and give it a value (count) of 1
    }
}

foreach my $key (sort keys %gene_hash)   # read through outer keys of hash table
{
    
    foreach my $key2 (sort keys %{$gene_hash{$key}} )          #read through inner keys
    {
        print OUT "$key\t", "$key2\t", "$gene_hash{$key}{$key2}" , "\n";              #print keys and count
    }
}


close INPUT;
close OUT;


##################################################
#
# Specify input and output file names here; open files
#
###################################################


my $input_file2 = "BLASTx_counted.txt";
my $output_file2 = "filled_draft_matrix.txt";
my $gene;
my @fields;

open (INPUT, $input_file2) or die "Unable to open input file, $input_file2";
open (OUT, ">$output_file2") or die "Unable to open output file, $output_file2";


print OUT "gene", "\t", "ERR_19", "\t" , "ERR_20", "\t" , "ERR_21","\t", "ERR_22","\t", "ERR_24","\t", "ERR_26", "\t" , "ERR_28", "\t" , "ERR_29","\t", "ERR_30", "\t" , "ERR_31", "\t" , "ERR_32", "\t", "ERR_33", "\t" , "ERR_34", "\t" , "ERR_35", "\t" , "ERR_36","\n";

#########
# Read through the BLASTx counted file, make hash table of gene ids, samples, gene counts
########



while ( <INPUT> )
{
    
    
    my $line = $_;
    
    chomp $line;
    
    @fields = split (/\t/, $line);
    
    $fields[2] =~s/\r//g;
    
    if ($fields[0] =~ m/(\S+)/)
    {
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_19/)  #change $fields[1] for unique sample id
            
        {
            $gene=$fields[0];
            print OUT "$gene\t", "$fields[2]\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0", "0\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_20/)   #change $fields[1] for unique sample id
            
        {
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "$fields[2]\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_21/)        #change $fields[1] for unique sample id
            
        {
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0\t", "$fields[2]\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_22/)  #change $fields[1] for unique sample id
        {
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0\t", "0\t", "$fields[2]\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_24/)   #change $fields[1] for unique sample id
        {
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0\t", "0\t", "0\t", "$fields[2]\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_26/)        #change $fields[1] for unique sample id
        {
            
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0t", "0\t", "0\t", "0\t", "$fields[2]\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_28/)  #change $fields[1] for unique sample id
        {
            $gene=$fields[0];
            
            print OUT "$gene\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "$fields[2]\t", "0\t", "0\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_29/)   #change $fields[1] for unique sample id
        {
            $gene=$fields[0];
            
            print OUT "$gene\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "$fields[2]\t", "0\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_30/)        #change $fields[1] for unique sample id
        {
            
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "$fields[2]\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_31/)        #change $fields[1] for unique sample id
        {
            
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "$fields[2]\t", "0\t",  "0\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_32/)        #change $fields[1] for unique sample id
        {
            
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "$fields[2]\t",  "0\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_33/)        #change $fields[1] for unique sample id
        {
            
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t",  "$fields[2]\t", "0\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_34/)        #change $fields[1] for unique sample id
        {
            
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t",  "0\t", "$fields[2]\t", "0\t", "0\t", "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_35/)        #change $fields[1] for unique sample id
        {
            
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "$fields[2]\t",  "0\t",  "\n"; #change number of tabs and zeros for unique number of samples
        }
        
        if ($fields[0] =~ m/jgi\S+/ and $fields[1] =~ m/ERR_36/)        #change $fields[1] for unique sample id
        {
            
            $gene=$fields[0];
            print OUT "$gene\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t", "0\t",  "0\t", "0\t", "0\t",  "$fields[2]\t",  "\n"; #change number of tabs and zeros for unique number of samples
        }
    }
    
}

close INPUT;
close OUT;

print "\n\n", "Now input this output into R and run the following command to sum duplicate rows(genes):", "\n", "> groups<-as.numeric(matrix[,1])", "\n", ">rowsum(matrix[,2:n], groups)", "\n", "Where n is the number of columns in the matrix (samples)", "\n\n";

