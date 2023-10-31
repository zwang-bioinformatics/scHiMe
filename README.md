# scHiMe
Required python packages:
1.	PyTorch (1.9.0)
2.	Numpy 
3.	scikit-learn


	
Required Hi-C files:
All Hi-C files should be saved in a folder. In our example, we saved all Hi-C files 
in “hic_file/” folder. There are 300 Hi-C files in our folder. They are “1.txt”, 
“2.txt”, …, and “300.txt”. For example, “1.txt” should contain the whole-genome Hi-C contacts for cell 1. All Hi-C files should be ended with “.txt.” You can use any name for the Hi-C files. We recommend that the total number of files or cells in your folder is large than 30 since we used 20 as the number of neighboring cells for building meta-cells. The number of cells used in our benchmark was 333, 1053, and 300 for data sets 1, 2, and 3. Predictions will be made if not using the recommended value, but the accuracy may differ from our benchmarking.   

	

Required Hi-C format:
Every file in the Hi-C folder should be in a fixed format as follows:

chr1    1263291       chr1    23946470

chr1    1482927       chr3    177964931

chr1    1700468       chr1    37652412

chr1    1722339       chr1    1842676 

chr1    1756612       chr1    1767210 

chr1    1767210       chr1    1767556 

chr1    2165063       chr1    2257005 

chr1    2996596       chr1    311331 


Columns 1 and 3 are chromosomes, and columns 2 and 4 are positions. Chromosome names “1”, ”2,”…, and “X” will also be fine. You can put inter-chromosome Hi-C contacts in the file, but our program will only use intra-chromosome Hi-C contacts.



Write input file for “scHiMe”:
The command line for converting Hi-C files into the input file for “scHiMe” is as follows:

“perl write_input.pl hic_file/ input.pkl 3”,

where “hic_file/” is the folder that contains your Hi-C files, “input.pkl” is the output file of this command line and will be the input file for “scHiMe”. The “3” is the number of cell types in your data. The input for the “scHiMe” must be ending with “.pkl.” The number of cell types is optional, but if a user inputs a value here, the cells used to build meta-cell will only be from the same type of cells, which will quite likely make the predictions more accurate. 



Run “scHiMe”:
The command line for running scHiMe is as follows:

“python Prediction.py input.pkl trained_model output.pkl”,

where “input.pkl” is the input generated from the previous step,  “trained_model” is the network model used for scHiMe, and “output.pkl” is the output of scHiMe, which contains the prediction for all cells.  



Extract predictions for each cell:
Since the output from scHiMe contains the prediction for all cells, we provide a way to separate the predictions by each cell. 
The  command line is as follows:     

“perl sep_output.pl hic_file/ output.pkl prediction_results/”,

where “hic_file/” is the folder that contains your Hi-C files, “output.pkl” is the output of scHiMe, and “prediction_results” is a folder that you should create first for saving the predictions for all cells. Under “prediction_results/,” multiple files will be created, each of which has the prefix file name of “Pred_”, followed by the Hi-C file names used in the Hi-C folder. In our example, the names should be “Pred_1.txt”, “Pred_2.txt”, …, and “Pred_300.txt”. Since the prediction files are large, we only save “Pred_1.txt” in the “prediction_results/” folder in this package.  
