open(IN0,"chr_pro_num");
my %hs;
while(<IN0>){
	my $line = $_;
	chomp $line;
	my @item = split(/\s+/,$line);
	$hs{$item[0]} = $item[1];
}
close(IN0);
my $file = "promoters_start_end";
open(IN,$file);
my $l = 0;
my %hash;
while(<IN>){
	my $line = $_;
	chomp $line;
	my @item = split(/\s+/,$line);
	for(my $i = $item[1]-4500; $i < $item[2]+4500; $i++){
		$hash{$item[0]." ".$i} = $l;
	}
	$l++;
}
close(IN);
`mkdir edges`;
open(IN2,"meta_cells");
while(<IN2>){
	my $line = $_;
	chomp $line;
	my @item = split(/\s+/,$line);
	for(my $i = 1; $i <= 23; $i ++){
		my $m = $i;
		if($i == 23){
			$m = "X";
		}
		my $c = 0;
		my %hash1;
		my %hash3;
		my $name1 = $item[0]+1;
		`mkdir edges/$name1`;
		foreach my $it (@item){
			my $name = $it + 1;
			open(IN3,"hics/$name/$i");

			while(<IN3>){
				my $line2 = $_;
				chomp $line2;
				my @item2 = split(/\s+/,$line2);
				my $p1 = $hash{$m." ".int($item2[1])} - $hs{$m};
				my $p2 = $hash{$m." ".int($item2[3])} - $hs{$m};
					if((exists $hash{$m." ".int($item2[1])}) && (exists $hash{$m." ".int($item2[3])})){
						if($p1 != $p2){
							$hash1{$p1." ".$p2." ".$c} = $hash1{$p1." ".$p2." ".$c} + 1;
							$hash3{$p1." ".$p2} = abs($item2[3] - $item2[1]);
						}
					}
			
			}
			close(IN3);
			$c++;
		}
		my $out = "edges/$name1/$i";
		open(OUT,">$out");
		foreach my $key (keys %hash3){
			print OUT "$key ";
			my $mc = 0;
			for(my $j = 0; $j < 21; $j++){
				if(exists $hash1{$key." $j"}){
					my $h = $hash1{$key." ".$j};
					$h = log($h+1)/log(2);
					$mc++;
					print OUT $h." ";
				}else{
					print OUT "0 ";
				}
			}
			$mc = $mc/21;
			print OUT $mc." ";
			my $dd = 0;
			if($hash3{$key}!=0){
				$dd = ((log($hash3{$key})/log(10))/5);
			}
			print OUT $dd."\n";
		}
		close(OUT);		
	}
}
close(IN2);
