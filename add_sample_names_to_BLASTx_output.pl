#!/usr/bin/perl -w
use strict;

##################################################
#
# Specify input and output file names here; open files
#
###################################################


my $input_file = $ARGV[0];  # this is the concatenated BLASTx output (m8)
my $output_file = "BLASTx_samples_added.txt";


open (INPUT, $input_file) or die "Unable to open input file, $input_file";
open (OUT, ">$output_file") or die "Unable to open output file, $output_file";


my %gene_hash;


while ( <INPUT> )  # read through the input file
{
    my $line = $_;
    
    chomp $line;                          #remove all newline (\n) characters from $line
    
    my @fields = split (/\t/, $line);     #split on tabs & make an array out of $line
   
    
    $fields[0] =~ s/ERR263036./ERR_36\t/g;
    $fields[0] =~ s/ERR263035./ERR_35\t/g;
    $fields[0] =~ s/ERR263034./ERR_34\t/g;
    $fields[0] =~ s/ERR263033./ERR_33\t/g;
    $fields[0] =~ s/ERR263032./ERR_32\t/g;
    $fields[0] =~ s/ERR263031./ERR_31\t/g;
    $fields[0] =~ s/ERR263030./ERR_30\t/g;
    $fields[0] =~ s/ERR263029./ERR_29\t/g;
    $fields[0] =~ s/ERR263028./ERR_28\t/g;
    $fields[0] =~ s/ERR263026./ERR_26\t/g;
    $fields[0] =~ s/ERR263024./ERR_24\t/g;
    $fields[0] =~ s/ERR263019./ERR_19\t/g;
    $fields[0] =~ s/ERR263022./ERR_22\t/g;
    $fields[0] =~ s/ERR263020./ERR_20\t/g;
    $fields[0] =~ s/ERR263021./ERR_21\t/g;
    
    
    print OUT "$fields[0]\t", "$fields[1]\t", "$fields[2]\t", "$fields[3]\t", "$fields[4]\t", "$fields[5]\t", "$fields[6]\t", "$fields[7]\n" ;
    
}
close INPUT;
close OUT;


