import torch

from torch_geometric.nn import TransformerConv
from torch_geometric.nn.norm import LayerNorm

# https://pytorch-geometric.readthedocs.io/en/latest/modules/nn.html#torch_geometric.nn.conv.TransformerConv

class GTrans(torch.nn.Module):
    def __init__(self):
        super(GTrans, self).__init__()
        #torch.manual_seed(12345) 
        self.conv1 = TransformerConv(in_channels=4101, out_channels=3400, heads=1, concat=True, beta=False, edge_dim=23) 
        self.norm1 = LayerNorm(3400)
        self.norm1_1 = LayerNorm(24)
        self.conv2 = TransformerConv(in_channels=3400, out_channels=2800, heads=1, concat=True, beta=False, edge_dim=24) 
        self.norm2 = LayerNorm(2800)
        self.norm2_1 = LayerNorm(24)
        self.conv3 = TransformerConv(in_channels=2800, out_channels=2200, heads=1, concat=True, beta=False, edge_dim=24)
        self.norm3 = LayerNorm(2200)
        self.norm3_1 = LayerNorm(24)
        self.conv4 = TransformerConv(in_channels=2200, out_channels=1600, heads=1, concat=True, beta=False, edge_dim=24)
        self.norm4 = LayerNorm(1600)
        self.norm4_1 = LayerNorm(24)
        self.conv5 = TransformerConv(in_channels=1600, out_channels=1000, heads=1, concat=True, beta=False, edge_dim=24)
    def forward(self, x, edge_index, edge_attr, return_attention_weights=True):
        
        x,(edge_index, edge_attr1) = self.conv1(x, edge_index, edge_attr, return_attention_weights=True)
        x = self.norm1(x)
       	x = x.relu() 
        edge_attr1 = torch.cat((edge_attr,edge_attr1),dim=1)
        edge_attr1 = self.norm1_1(edge_attr1)
        edge_attr1 = edge_attr1.relu()

        x,(edge_index, edge_attr2) = self.conv2(x, edge_index, edge_attr1, return_attention_weights=True)
        x = self.norm2(x)
        x = x.relu()
        edge_attr2 = torch.cat((edge_attr,edge_attr2),dim=1)
        edge_attr2 = self.norm2_1(edge_attr2)
        edge_attr2 = edge_attr2.relu()

        x,(edge_index, edge_attr3) = self.conv3(x, edge_index, edge_attr2,return_attention_weights=True)
        x = self.norm3(x)
        x = x.relu()
        edge_attr3 = torch.cat((edge_attr,edge_attr3),dim=1)
        edge_attr3 = self.norm3_1(edge_attr3)
        edge_attr3 = edge_attr3.relu()

        x,(edge_index, edge_attr4) = self.conv4(x, edge_index, edge_attr3, return_attention_weights=True)
        x = self.norm4(x)
        x = x.relu()
        edge_attr4 = torch.cat((edge_attr,edge_attr4),dim=1)
        edge_attr4 = self.norm4_1(edge_attr4)
        edge_attr4 = edge_attr4.relu()
        
        x, (edge_index, edge_attr5) = self.conv5(x, edge_index, edge_attr4, return_attention_weights=True)

        return torch.sigmoid(x)
