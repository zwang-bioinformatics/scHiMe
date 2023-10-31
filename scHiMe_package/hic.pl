my $dir = $ARGV[0];
opendir(DIR,$dir);
my @items = readdir(DIR);
my %hash;
`mkdir hics`;
my $l = 1;
foreach my $it (@items){
        if($it eq "" || $it eq " " || $it eq ".." || $it eq "."){
                next
        }
	#print $it."\n";
	my $name = $l;
	#print $name."\n";
	`mkdir hics/$name`;
	for(my $i = 1; $i <= 23; $i++){
		my $m = "chr".$i;
		my $m1 = $i;
		if($i == 23){
			$m = "chrX";
			$m1 = "X";
		}
		
		open(IN2,$dir."/$it");
		open(OUT,">hics/$name/$i");
		while(<IN2>){
			my $line = $_;
			my @item = split(/\s+/,$line);
			if($item[0] eq $item[2] && $item[0] eq $m){
				print OUT $line; 
			}elsif($item[0] eq $item[2] && $item[0] eq $m1){
				print OUT $line;
			}
		}
		close(OUT);
		close(IN);
	}
	$l++;
}
