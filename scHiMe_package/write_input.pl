my $file = $ARGV[0];
my $file2 = $ARGV[1]; #output file for make prediction. Also knowns as the input file for make prediciton.
my $num_cell = $ARGV[2];#number of cell types. Optional. 

opendir(DIR,$file);

my @items = readdir(DIR);

my $len = 0; # number of cells in the folder

foreach my $it (@items){
        if($it eq "" || $it eq " " || $it eq ".." || $it eq "."){
                next
        }
	$len++;
}
closedir(DIR);
`perl hic.pl $file`;
`perl sc.pl $file $num_cell`;
`perl edge.pl`;
`rm -r hics/`;
`rm -r schics/`;
`rm -r meta_cells`;
open(OUT,">run_input.sh");
print OUT "python creat.py $len $file2\n";
close(OUT);
`chmod 755 run_input.sh`;
`./run_input.sh`;
`rm run_input.sh`;
`rm -r edges`;
`rm scout`;
