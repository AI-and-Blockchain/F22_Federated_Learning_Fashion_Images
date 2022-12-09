import numpy as np
from Pyfhel import Pyfhel, PyCtxt
import json

def nomralize(x):
    return (x - np.mean(x)) / np.std(x)

def encrypt_img(img, data_provider):
    encrypted_img = []
    for i in img:
        tmp = []
        for j in i:
            tmp.append(data_provider.encrypt(j).to_bytes().decode('cp437'))
        encrypted_img.append(tmp)
    return encrypted_img

def provider():
    data_provider = Pyfhel(context_params={'scheme':'ckks', 'n':2**13, 'scale':2**30, 'qi_sizes':[30]*5})

    # generate key pair
    data_provider.keyGen()
    data_provider.relinKeyGen()
    data_provider.rotateKeyGen()

    data = np.loadtxt("./encrypt/sample1.csv", delimiter=',', dtype=float)
    y = data[:2, 0]
    img = nomralize(data[:2, 1:])
    img_r = np.ndarray(shape=(len(img), 28, 28), dtype=float)
    for i in range(len(img)):
        img_r[i] = np.reshape(img[i], (28, 28))

    s_encrypted_data = []
    for i in img_r:
        s_encrypted_data.append(encrypt_img(i, data_provider))
        
    s_encrypted_label = []
    for i in y:
        s_encrypted_label.append(data_provider.encrypt(i).to_bytes().decode('cp437'))
                
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
        'data':     s_encrypted_data,
        'labels':   s_encrypted_label
    }
    to_send = json.dumps(to_send)
    return to_send

if __name__ == "__main__":
    provider()