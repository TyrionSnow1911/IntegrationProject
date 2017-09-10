use strict;
use warnings;
use Cwd;
use Spreadsheet::WriteExcel;

my $dir  = getcwd;
my $inputDir = "$dir\\Test_Cases\\input";
my $outputDir = "$dir\\Test_Cases\\output";
#read input files.
opendir (DIR, $inputDir) or die "Cannot open $inputDir!\n";
my @inputFiles = readdir DIR;
closedir DIR;
@inputFiles = grep {/.txt$/} @inputFiles;
#read output files.
opendir (DIR, $outputDir) or die "Cannot open $outputDir!\n";
my @outputFiles = readdir DIR;
closedir DIR;
@outputFiles = grep {/.txt$/} @outputFiles;

my $i = 0;
my $j = 0;

while ($i < scalar @inputFiles && $j < scalar @outputFiles) {	system("\"$dir\\BalancedBrackets.exe\" \"$dir\\Test_Cases\\input\\$inputFiles[$i]\" \"$dir\\Test_Cases\\output\\$outputFiles[$j]\"");	$i++; $j++;}
#parse output file and write results to excel spreadsheet.
#write results to excel spreadsheet.
open my $fh, "<", "$dir\\output.txt" or die "Cannot open $dir\\output.txt!\n"; #open output file for reading.

my $wb = Spreadsheet::WriteExcel->new("$dir/results.xls"); #open new excel file for writing results of each test.
my $ws = $wb->add_worksheet();$ws->write(0,0, "Input String"); # write column 1 title.
$ws->write(0,1, "Actual Result"); #write column 2 title.
$ws->write(0,2, "Expected Result"); # write column 3 title.
$ws->write(0,3, "Pass//Fail"); # write column 4 title.

my $row = 1;
my $col = 0;
my $k;
my $len;
while (my $line = <$fh>) {
	chomp $line;
	my @data = split (/ /, $line);
	$len = scalar @data;
	for ($k = 0; $k < $len; $k++) {
		$ws->write($row, $col, $data[$k]);
		$col++;
		}
		$col = 0;
		$row++;	}
close $fh;
