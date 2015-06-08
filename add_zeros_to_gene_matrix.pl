#!/usr/bin/perl -w
use strict;

my $input = $ARGV[0];

my $output_file = $ARGV[1];
my $line;
my @lines;
my $lines;

print "\nProgram started ............\n";

open (INPUT, $input) or die "Unable to open reads input file, $input";

open (OUT, ">$output_file") or die "Unable to open output file, $output_file";


#########
# Read through the matrix and convert any missing values to zeros
########


    while ( <INPUT>)
{
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    
    $fields[1] =~ s/^\z/0/g;
    $fields[2] =~ s/^\z/0/g;
    $fields[3] =~ s/^\z/0/g;
    $fields[4] =~ s/^\z/0/g;
    $fields[5] =~ s/^\z/0/g;
    $fields[6] =~ s/^\z/0/g;
    $fields[7] =~ s/^\z/0/g;
    $fields[7] =~ s/^\z/0/g;
    $fields[8] =~ s/^\z/0/g;
    $fields[9] =~ s/^\z/0/g;
    
    print OUT "$fields[0]", "\t", "$fields[1]", "\t", "$fields[2]", "\t", "$fields[3]", "\t", "$fields[4]","\t", "$fields[5]","\t", "$fields[6]","\t", "$fields[7]","\t", "$fields[8]","\t", "$fields[9]","\n";
}


close INPUT;
close OUT;

