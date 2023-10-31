my $file0 = $ARGV[0];
my $file = $ARGV[1];
my $file2 = $ARGV[2];
`python sep.py $file $file2`;
`perl sep_results.pl $file0 $file2`;
