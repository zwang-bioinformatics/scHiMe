my $file = $ARGV[0];
my $file2 = $ARGV[1];
opendir(DIR,$file);
my @items = readdir(DIR);
my $len = 0; # number of cells in the folder
foreach my $it (@items){
        if($it eq "" || $it eq " " || $it eq ".." || $it eq "."){
                next
        }
		`perl comb.pl $file2/$len >$file2/Pred_$it`;
		`rm $file2/$len`;
		
        $len++;
}
closedir(DIR);
