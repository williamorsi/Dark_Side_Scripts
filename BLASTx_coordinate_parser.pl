#!/usr/bin/perl -w
use strict;



my $reads_input = $ARGV[0];

my $output_file = $ARGV[1];

print "\nProgram started ............\n";

open (READS, $reads_input) or die "Unable to open reads input file, $reads_input"; 

open (OUTPUT, ">$output_file") or die "Unable to open output file, $output_file";

print "Input and Output Files were successfully opened ......\n";

while ( <READS> )
{
    my $line = $_;
    
    chomp $line;
    
    my @fields = split (/\t/, $line);
    
    if ($fields[2] ge 59)
    {
            print OUTPUT "$fields[1]", "\n";
        }
}



close READS;
close OUTPUT;

print "\nProgram Complete ..............\n";
