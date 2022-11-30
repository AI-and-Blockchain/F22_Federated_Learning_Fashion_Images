import numpy as np
from Pyfhel import Pyfhel, PyCtxt
import json

def provider():
    data_provider = Pyfhel(context_params={'scheme':'ckks', 'n':2**13, 'scale':2**30, 'qi_sizes':[30]*5})

    # generate key pair
    data_provider.keyGen()
    data_provider.relinKeyGen()
    data_provider.rotateKeyGen()

    data = np.loadtxt("./encrypt/sample1.csv", delimiter=',', dtype=float)

    s_encrypted_data = []
    for i in data:
        s_encrypted_data.append(data_provider.encrypt(i).to_bytes().decode('cp437'))
    
    # convert to bytes to transfer
    s_context           = data_provider.to_bytes_context()
    s_public_key        = data_provider.to_bytes_public_key()
    s_relin_key         = data_provider.to_bytes_relin_key()
    s_rotate_key        = data_provider.to_bytes_rotate_key()           
           
    to_send = {
        'context':  s_context.decode('cp437'),
        'pk':       s_public_key.decode('cp437'),
        'rlk':      s_relin_key.decode('cp437'),
        'rtl':      s_rotate_key.decode('cp437'),
        'data':     s_encrypted_data
    }
    to_send = json.dumps(to_send)
    return to_send

if __name__ == "__main__":
    provider()