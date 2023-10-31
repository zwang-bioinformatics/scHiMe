import pickle
import sys
import os
import numpy as np

batch = []
len1 = int(sys.argv[1]) + 1;
for i in range(1,len1):
#	print(i)
	nedge = "edges/"+str(i)+"/";
	for j in range(23):
		
		edge = np.loadtxt(nedge+str(j+1))
		m = []
		if edge.size!=0:
			eg = edge[:,0:2]
			ef = edge[:,2:25]
			m.append(j)
			m = np.array(m)
			batch.append([eg,ef,m])
		#	print(eg.shape,ef.shape,m.shape)
		else:
			eg = np.zeros((1,2))
			ef = np.zeros((1,23))
			m.append(i)
			m = np.array(m)
			batch.append([eg,ef,m])
			print(eg.shape,ef.shape,m.shape)
with open(sys.argv[2],"wb") as fp:
	pickle.dump(batch,fp)
