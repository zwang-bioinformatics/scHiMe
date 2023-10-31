print "Promoter id|Gene name|Chromosome|Promoter start|Promoter end|Promoter seq|Predicted base-pair-specific methylation levels of promoter\n";
my $file = "front_inf.txt";
open(IN,$file);
my %hash;
my $l = 0;
while(<IN>){
	my $line = $_;
	chomp $line;
	$hash{$l} = $line;
	#my @item = split(/\s+/,$line);
	#foreach my $it (@item){
	#	$hash{$l}=$hash{$l}."$it;";
		
	#}
	$l++;
}
close(IN);
my $file2 = $ARGV[0];
my $l2 = 0;
open(IN2,$file2);
while(<IN2>){
	my $line = $_;
	chomp $line;
	print $hash{$l2}."$line\n";
	$l2++;
}
close(IN2);
