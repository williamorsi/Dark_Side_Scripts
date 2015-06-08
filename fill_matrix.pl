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
   

    
    $fields[0] =~ s/_CAM_READ_\d+//g;  # remove all the crap after "631", leaving just the number to parse in the fill matrix step
    
    
    
    my $sample = $fields[0];
   
    my $gene = $fields[1];                 # pull gene from second column
    
    if ( $gene_hash{$gene}{$sample} and $fields[2] ge 59)         # if sample-gene combination exists and has greater than 59% homology
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


print OUT "gene", "\t", "631", "\t" , "632", "\t" , "633", "\t", "637", "\t" , "638", "\t" , "639", "\t", "640", "\t" , "641", "\t" , "642","\n";

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
        
        if ($fields[0] =~ m/\S+/ and $fields[1] =~ m/631/)  #change $fields[1] for unique sample id
            
        {
            $gene=$fields[0];
            print OUT "$gene", "\t", "$fields[2]","\t", "0", "\t", "0", "\t", "0", "\t", "0","\t", "0", "\t", "0","\t", "0", "\t", "0","\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/(\S+)/ and $fields[1] =~ m/632/)   #change $fields[1] for unique sample id
            
        {
            $gene=$fields[0];
            print OUT "$gene", "\t", "0", "\t", "$fields[2]", "\t", "0", "\t", "0", "\t", "0","\t", "0", "\t", "0","\t", "0", "\t", "0","\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/(\S+)/ and $fields[1] =~ m/633/)        #change $fields[1] for unique sample id
            
        {
            $gene=$fields[0];
            print OUT "$gene", "\t", "0", "\t", "0", "\t", "$fields[2]", "\t", "0", "\t", "0","\t", "0", "\t", "0","\t", "0", "\t", "0","\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        if ($fields[0] =~ m/(\S+)/ and $fields[1] =~ m/637/)  #change $fields[1] for unique sample id
        {
            $gene=$fields[0];
            print OUT "$gene", "\t", "0", "\t", "0", "\t", "0", "\t", "$fields[2]", "\t", "0","\t", "0", "\t", "0","\t", "0", "\t", "0","\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/(\S+)/ and $fields[1] =~ m/638/)   #change $fields[1] for unique sample id
        {
            $gene=$fields[0];
            print OUT "$gene", "\t", "0", "\t", "0", "\t", "0", "\t", "0", "\t", "$fields[2]","\t", "0", "\t", "0","\t", "0", "\t", "0","\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/(\S+)/ and $fields[1] =~ m/639/)        #change $fields[1] for unique sample id
        {
            
            $gene=$fields[0];
            print OUT "$gene", "\t", "0", "\t", "0", "\t", "0", "\t", "0", "\t", "0","\t", "$fields[2]", "\t", "0","\t", "0", "\t", "0","\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/(\S+)/ and $fields[1] =~ m/640/)  #change $fields[1] for unique sample id
        {
            $gene=$fields[0];
            
            print OUT "$gene", "\t", "0", "\t", "0", "\t", "0", "\t", "0", "\t", "0","\t", "0", "\t", "$fields[2]","\t", "0", "\t", "0","\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        if ($fields[0] =~ m/(\S+)/ and $fields[1] =~ m/641/)   #change $fields[1] for unique sample id
        {
            $gene=$fields[0];
            
            print OUT "$gene", "\t", "0", "\t", "0", "\t", "0", "\t", "0", "\t", "0","\t", "0", "\t", "0","\t", "$fields[2]", "\t", "0","\n"; #change number of tabs and zeros for unique number of samples
        }
        
        
        
        
        if ($fields[0] =~ m/(\S+)/ and $fields[1] =~ m/642/)        #change $fields[1] for unique sample id
        {
            
            $gene=$fields[0];
            print OUT "$gene", "\t", "0", "\t", "0", "\t", "0", "\t", "0", "\t", "0","\t", "0", "\t", "0","\t", "0", "\t", "$fields[2]","\n"; #change number of tabs and zeros for unique number of samples
        }
    }
    
}

close INPUT;
close OUT;

print "\n\n", "Now input this output into R and run the following command to sum duplicate rows(genes):", "\n", "> groups<-as.numeric(matrix[,1])", "\n", ">rowsum(matrix[,2:n], groups)", "\n", "Where n is the number of columns in the matrix (samples)", "\n\n";

