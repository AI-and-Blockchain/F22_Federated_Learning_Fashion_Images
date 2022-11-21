import numpy as np
from Pyfhel import Pyfhel
import json

data_provider = Pyfhel(context_params={'scheme':'ckks', 'n':2**13, 'scale':2**30, 'qi_sizes':[30]*5})

# generate key pair
data_provider.keyGen()
data_provider.relinKeyGen()
data_provider.rotateKeyGen()

data = np.loadtxt("sample1.csv", delimiter=',', dtype=float)

data_list = []
for i in data:
    data_list.append(data_provider.encrypt(i))
data_list = np.array(data_list)

# convert to bytes to transfer
s_context           = data_provider.to_bytes_context()
s_public_key        = data_provider.to_bytes_public_key()
s_relin_key         = data_provider.to_bytes_relin_key()
s_rotate_key        = data_provider.to_bytes_rotate_key()
s_encrypted_data    = data_list.tobytes()

to_send = {
    'context':  s_context.decode('cp437'),
    'pk':       s_public_key.decode('cp437'),
    'rlk':      s_relin_key.decode('cp437'),
    'rtl':      s_rotate_key.decode('cp437'),
    'data':     s_encrypted_data.decode('cp437')
}
to_send = json.dumps(to_send)