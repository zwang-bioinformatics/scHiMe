import sys
import numpy as np
import pickle
import os
import datetime
from torch.utils import data
import torch
from torch.autograd import Variable
from time import gmtime, strftime
import torch.nn as nn
import torch.nn.functional as F
import random


from Network import *





bert = []
with open("node_feature.pkl","rb") as filehandle:
	bert = pickle.load(filehandle)

dtrain = []
with open(sys.argv[1], 'rb') as filehandle:
  dtrain = pickle.load(filehandle)




device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

model = GTrans().to(device)
model.load_state_dict(torch.load(sys.argv[2]))
model.eval()


batchs=[]
for batch in dtrain:
	si = int(batch[2][0])
	x = Variable(torch.from_numpy(bert[si])).to(device, dtype=torch.float)


	edge = Variable(torch.from_numpy(batch[0].transpose())).to(device, dtype=torch.long)
	edge_f = Variable(torch.from_numpy(batch[1])).to(device, dtype=torch.float)

	out = model(x, edge, edge_f)
	out2 = out.cpu().data.numpy()
	batchs.append(out2)
with open(sys.argv[3],"wb") as fp:
	pickle.dump(batchs,fp)

