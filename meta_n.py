import numpy as np
from sklearn.cluster import SpectralClustering
import sys
from scipy.spatial import distance
X = np.loadtxt(sys.argv[1])
cls = SpectralClustering(n_clusters=int(sys.argv[2]),assign_labels='discretize',random_state=0,affinity="nearest_neighbors").fit(X)

cl = cls.labels_

cs = []
cc = []
for i in range(int(sys.argv[2])):
	ci = X[cl == i,:]
	cs.append(ci)
	cc1 = np.where(cl==i)[0]
	cc.append(cc1)
for c in range(int(sys.argv[2])):
	for i in cs[c]:
		m = []
		for j in cs[c]:
			dst = distance.euclidean(i,j)
			m.append(dst)
		m = np.array(m)
		n = cc[c]
		n = np.array(n)
		for g in n[np.argsort(m)[0:21]]:
			print(g,end=" ")
		print()
		#print(cc[c][np.argsort(m)[::-1][0:21]])		

