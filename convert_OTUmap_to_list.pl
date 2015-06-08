#!/usr/bin/perl -w
use strict;



my $output_file = "MGII_OTU_MAP.txt";
my $header_list = "MGII_seqs_list_for_filterfasta.txt";
my @fields;


open (OUTPUT, "$output_file") or die "Unable to open output file, $output_file";
open (LIST, ">$header_list") or die "Unable to open taxonomy input file, $header_list";

while ( <OUTPUT>)

{
    my $line = $_;
    chomp $line;
    my @lines = split (/"\n"/, $line);
    
    $lines[0] =~ s/(\t)/\n/g;
    
    print LIST "$lines[0]\n";
}
    

close OUTPUT;
close LIST;


print "\nProgram Complete ..............\n";

