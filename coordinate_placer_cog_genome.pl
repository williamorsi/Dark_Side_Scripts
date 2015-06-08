#!/usr/bin/perl -w
use strict;



my $reads_input = "Iverson_coordinates.txt";
my $cogs_input = "0.1_0.8_3_blastx_counted_combined_percent_LOG_transformed.txt";

my $output_file = "Iverson_all_size_metagenomes_mapped_w_coordinates.txt";

my %hash_table;
my $hash_count = 0;
my $cogs_count = 0;

print "\nProgram started ............\n";

open (READS, $reads_input) or die "Unable to open reads input file, $reads_input"; 
open (COGS, $cogs_input) or die "Unable to open cogs input file, $cogs_input";

open (OUTPUT, ">$output_file") or die "Unable to open output file, $output_file";

print "Input and Output Files were successfully opened ......\n";

$/ = "\r";

while ( <READS> )
{
    my $line = $_;
    my @fields = split (/\t/, $line);
    if ($fields[0] =~ m/(MG2_\d*)/)
    {
        $hash_table{$1} = $fields[1];
        $hash_count++;
    }
}

print "Hash-table of $hash_count read counts created .......\n";

print OUTPUT "Locus_tag\tAnnotation\tCoordinates\n";

while ( <COGS> )
{
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    my $reads = 0;
    if ($fields[0] =~ m/(MG2_\d*)/)
        {
            my $contig = $1;
            my $reads = $hash_table{$contig};
            print OUTPUT "$fields[0]","\t", "$fields[2]", "\t", "$reads";
            $cogs_count++;
        }
}

print "Output file, $output_file, created with $cogs_count entries...........\n";

close READS;
close COGS;
close OUTPUT;

print "\nProgram Complete ..............\n";
