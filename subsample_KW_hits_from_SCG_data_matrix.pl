#!/usr/bin/perl -w
use strict;



my $KW_matrix = $ARGV[0];
my $SCG_matrix = $ARGV[1];

my $output_file = $ARGV[2];

my %hash_table;
my $hash_count = 0;
my $cogs_count = 0;

print "\nProgram started ............\n";

open (KW_hits, $KW_matrix) or die "Unable to open contig/reads input file, $KW_matrix";
open (MATRIX, $SCG_matrix) or die "Unable to open taxonomy input file, $SCG_matrix";

open (OUTPUT, ">$output_file") or die "Unable to open output file, $output_file";

print "Input and Output Files were successfully opened ......\n";

$/ = "\r";

while ( <MATRIX> )
{
    my $line = $_;
    
    $line =~ s/\r//;
    
    my @fields = split (/\t/, $line);
    
    if ($fields[0] =~ m/(AAA\S+)/)
    {
        my $list = "";
        for (my $i=1; $i <=$#fields; $i++)
        {
            $list = $list . $fields[$i] . ";"
        }
        $hash_table{$1} = $list;
        $hash_count++;
    }
}

$/ = "\n";

print "Hash-table of $hash_count genome records created .......\n";

my $annotations_count = 0;

while ( <KW_hits> )
{
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    my @abundances;
    if ($fields[0] =~ m/(AAA\S+)/)
    
    {
        my $gene = $1;
        print OUTPUT "$fields[0]", "\t";
        
        if ($hash_table{$gene})
        {
            my $abundance = $hash_table{$gene};
            @abundances = split (/;/, $abundance);
            
            for (my $i=0; $i <= $#abundances; $i++)
            {
                print OUTPUT "$abundances[$i]", "\t";
            }
            
         }
        
        print OUTPUT "\n";
        $cogs_count++;
        
    }
}




print "Output file, $output_file, created with $cogs_count entries...........\n";

close KW_hits;
close MATRIX;
close OUTPUT;

print "\nProgram Complete ..............\n";

