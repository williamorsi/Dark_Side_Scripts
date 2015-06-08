#!/usr/bin/perl -w
use strict;



my $coordinates_input = "Iverson_coordinates.txt";

my $metagenome_hits = "642_blastx_counted_ge_30_id.txt";

my $output_file = "642_blastx_ge_30_MGII_coordinates_mapped.txt";

my %hash_table;
my $hash_count = 0;
my $gene_count = 0;

print "\nProgram started ............\n";

open (COORDINATES, $coordinates_input) or die "Unable to open reads input file, $coordinates_input"; 
open (METAGENOME, $metagenome_hits) or die "Unable to open cogs input file, $metagenome_hits";

open (OUTPUT, ">$output_file") or die "Unable to open output file, $output_file";

print "Input and Output Files were successfully opened ......\n";

$/ = "\r";

#########
# Read through the coordinates file, make hash table of gene ids and coordinates
########

while ( <COORDINATES> )
{

    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);

	if ($fields[1] =~ m/(\.+)/)

{
	$fields[1] =~ s/\.\./\t/g;

	$fields[1] =~ s/\(/\t/g;

	$fields[1] =~ s/\)/\ /g;

}

    if ($fields[0] =~ m/(\d+)/)
    {
        $hash_table{$1} = $fields[1];
        $hash_count++;
    }
}

print "Hash-table of $hash_count gene counts created .......\n";

print OUTPUT "gene_oid", "\t", "count", "\t", "start", "\t", "stop", "\t", "strand", "\n";

while ( <METAGENOME> )
{
    my $line = $_;
    chomp $line;
    my @fields = split (/\t/, $line);
    my $reads;
    if ($fields[0] =~ m/(\d+)/)
        {
            my $gene = $1;
            my $reads = $hash_table{$gene};
            print OUTPUT "$fields[0]","\t", "$fields[2]", "\t", "$reads";
            $gene_count++;
        }
}

print "Output file, $output_file, created with $gene_count entries...........\n";

close COORDINATES;
close METAGENOME;
close OUTPUT;

print "\nProgram Complete ..............\n";
