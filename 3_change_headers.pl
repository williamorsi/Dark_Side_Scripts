#!/usr/bin/perl -w

use strict;



my $qiimeheaders = "qiime_formatted_headers.txt";
my $dataframe = "qiime_formatted_fasta.fa";

my $output_file = "qiime_formatted_dataframe.txt";

my %hash_table;
my $hash_count = 0;
my $cogs_count = 0;

open (HEADERS, $qiimeheaders) or die "Unable to open reads input file, $qiimeheaders";
open (DATAFRAME, $dataframe) or die "Unable to open cogs input file, $dataframe";

open (OUTPUT, ">$output_file") or die "Unable to open output file, $output_file";

while ( <DATAFRAME> )
{
    my $line = $_;
    my @fields = split (/\t/, $line);
    
    if ($fields[0] =~ m/(HWI\S+)/)
    {
        $hash_table{$1} = $fields[1];
        $hash_count++;
    }
}

print "Hash-table of $hash_count read counts created .......\n";

while ( <HEADERS> )
{
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    my $reads;
    if ($fields[0] =~ m/(HWI\S+)/)
        {
            my $contig = $1;
            my $reads = $hash_table{$contig};
            print OUTPUT "$fields[1]", " \t", "$reads", "\n";
        }
    
}

close DATAFRAME;
close HEADERS;
close OUTPUT;
