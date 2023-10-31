import pickle
import sys
import numpy as np

pred = []
with open(sys.argv[1],"rb") as fh:
	pred = pickle.load(fh)

fold = sys.argv[2]+"/";
c=0
for i in range(0,len(pred),23):
	m = np.array(pred[i])
	for j in range(i+1,i+23):
		m = np.concatenate((m,np.array(pred[j])),0)
	np.savetxt(fold+str(c),m,fmt='%1.4f')
	c=c+1


	
