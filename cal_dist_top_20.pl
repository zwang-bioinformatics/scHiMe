my $file = $ARGV[0];
open(IN,$file);
my @a;
while(<IN>){
	my $line = $_;
	chomp $line;
	push(@a,$line);
}
foreach my $it (@a){
	my %hash;
	my $c = 0;
	foreach my $it2 (@a){
		my @item = split(/\s+/,$it);
		my @ite2 = split(/\s+/,$it2);
		my $l = @ite2;
		my $sum = 0;
		for(my $i = 0; $i < $l; $i++){
			$sum += ($item[$i] - $ite2[$i])**2;
		}
		my $dist = sqrt($sum);
		$hash{$c} = $dist;
		$c++;
	}
	my $cc = 0;
	foreach my $key (sort{$hash{$a} <=> $hash{$b}} keys %hash){
		if($cc < 21){
			print $key." ";
		}
		$cc++;
	}
	print "\n";
}
