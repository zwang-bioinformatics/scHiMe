
import sys
import numpy as np
import scipy.sparse as sp
from sklearn.decomposition import PCA
from sklearn.manifold import TSNE
from scHiCluster import *

dir_HiC = sys.argv[1]#"4cells_1M"

n_nodes = 3030
numbers = int(sys.argv[2])
num1 = numbers + 1
cells = []
hics = []
	
for line in range(1,num1):
	edges = np.loadtxt(dir_HiC+"/"+str(line))
	adj = sp.csr_matrix((edges[:,2], (np.int_(edges[:, 0]), np.int_(edges[:, 1]))), shape=(n_nodes, n_nodes))
	adj = adj + adj.T - sp.diags(adj.diagonal())
	hics.append(adj)

chrbins = np.loadtxt('chr_humsn', dtype='int')
nchrs = chrbins.shape[0]

pcn1 = 30
ncells = numbers

# for each chrs
#pcaChrs = np.zeros((ncells, pcn1*nchrs))

pcaChrs = []

for k in range(nchrs):
	# for each cells
	n = chrbins[k][1] - chrbins[k][0] 
	X = np.zeros((ncells, n*n))
	for i in range(ncells):
		celli = hics[i].toarray()
		cellik = celli[chrbins[k][0]:chrbins[k][1], chrbins[k][0]:chrbins[k][1]]+1
		bi = scHiCluster(cellik)
		X[i,:] = bi
	#print(X)
	ndim = int(min(X.shape) * 0.2) - 1
	pca = PCA(n_components=ndim)
	#pca.fit(X)
	X2 = pca.fit_transform(X) # 150*3
	#k1 = k*pcn1
	#k2 = k1 + pcn1
	#pcaChrs[:, k1:k2] = X2
	pcaChrs.append(X2)


pcaChrs = np.concatenate(pcaChrs, axis=1)
pca2 = PCA(n_components=min(pcaChrs.shape) - 1)
pcaChrs = pca2.fit_transform(pcaChrs)
np.savetxt(sys.argv[3],pcaChrs,fmt='%1.5f')



