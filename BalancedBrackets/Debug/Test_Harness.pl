use strict;
use warnings;
use Cwd;
use Spreadsheet::WriteExcel;

my $dir  = getcwd;
my $inputDir = "$dir\\Test_Cases\\input";
my $outputDir = "$dir\\Test_Cases\\output";

opendir (DIR, $inputDir) or die "Cannot open $inputDir!\n";
my @inputFiles = readdir DIR;
closedir DIR;
@inputFiles = grep {/.txt$/} @inputFiles;

opendir (DIR, $outputDir) or die "Cannot open $outputDir!\n";
my @outputFiles = readdir DIR;
closedir DIR;
@outputFiles = grep {/.txt$/} @outputFiles;


my $j = 0;

while ($i < scalar @inputFiles && $j < scalar @outputFiles) {

#write results to excel spreadsheet.
open my $fh, "<", "$dir\\output.txt" or die "Cannot open $dir\\output.txt!\n"; #open output file for reading.

my $wb = Spreadsheet::WriteExcel->new("$dir/results.xls"); #open new excel file for writing results of each test.
my $ws = $wb->add_worksheet();
$ws->write(0,1, "Actual Result"); #write column 2 title.
$ws->write(0,2, "Expected Result"); # write column 3 title.
$ws->write(0,3, "Pass//Fail"); # write column 4 title.


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
		$row++;
close $fh;