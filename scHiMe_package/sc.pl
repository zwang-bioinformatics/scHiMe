my $dir = $ARGV[0];
opendir(DIR,$dir);
my @items = readdir(DIR);
my %hash;
`mkdir schics`;
my $l = 0;
foreach my $it (@items){
        if($it eq "" || $it eq " " || $it eq ".." || $it eq "."){
                next
        }
	my $nameid = $l+1;
	`perl schic2.pl $dir/$it >schics/$nameid`;
	$l++;
}
open(OUT,">clust.sh");

print OUT "python run_scHiCluster.py schics $l scout\n";
close(OUT);
`chmod 755 clust.sh`;
`./clust.sh`;
`rm clust.sh`;
my $s = $ARGV[1];
if($s == 0){
	`perl cal_dist_top_20.pl scout >meta_cells`;
}else{
	`python meta_n.py scout $s >meta_cells`;
}
