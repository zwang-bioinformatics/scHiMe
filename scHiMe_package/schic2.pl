my $file = "human_list";
my $res = "1000000";
open(IN,$file);
my $l = 0;
my %hash;
my %hash0;
while(<IN>){
	my $line = $_;
	chomp $line;
	my @item = split(/\s+/,$line);
	my $l2 = int($item[1]/$res);
	my $l3 = 0;
	for(my $i = $l; $i < $l + $l2; $i++){
		my $s = int($item[1]/$res);
		$hash{$item[0]." $l3"} = $i;
		$hash0{"chr$item[0] $l3"} = $i;
		$l3++;
	}
	$l = $l + $l2;
}
close(IN);
my $file2 = $ARGV[0];
open(IN2,$file2);
my $count = 0;
my $str = 0;
my %hash2;
while(<IN2>){
	my $line = $_;
	chomp $line;
	my @item = split(/\s+/,$line);
	my $s1 = int($item[1]/$res);
	my $s2 = int($item[3]/$res);
	if($count==0){
		if(substr($item[0],0,1) eq "c"){
			$str = 1;
		}
	}
	if($str == 1){
		my $p1 = $hash0{$item[0]." $s1"};
		my $p2 = $hash0{$item[2]." $s2"};
		if(exists $hash0{$item[0]." $s1"} && exists $hash0{$item[2]." $s2"}){
			$hash2{$p1." $p2"} += 1;
			$hash2{$p2." $p1"} += 1;
		}
	}else{
                my $p1 = $hash{$item[0]." $s1"};
                my $p2 = $hash{$item[2]." $s2"};
		if(exists $hash0{$item[0]." $s2"} && exists $hash0{$item[2]." $s2"}){
                	$hash2{$p1." $p2"} += 1;
			$hash2{$p2." $p1"} += 1;
		}
	}

	$count++;
}
close(IN2);
foreach my $key (keys{%hash2}){
	my @item = split(/\s+/,$key);
	if($item[0] < $item[1]){
		print $key." $hash2{$key}\n";
	}
	if($item[0] == $item[1]){
		my $s2 = $hash2{$key};
		$s2 = $s2/2;
		print $key." $s2\n";
	}
}
