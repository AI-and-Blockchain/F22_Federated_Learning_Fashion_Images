import numpy as np
from Pyfhel import Pyfhel, PyCtxt
import json

# for test
from DataProvider import provider

receive = provider()
receive = json.loads(receive)

trainer = Pyfhel()
trainer.from_bytes_context(receive['context'].encode('cp437'))
trainer.from_bytes_public_key(receive['pk'].encode('cp437'))
trainer.from_bytes_relin_key(receive['rlk'].encode('cp437'))
trainer.from_bytes_rotate_key(receive['rtl'].encode('cp437'))

print(trainer)

data = np.ndarray(shape=(len(receive['data']), len(receive['data'][0]), len(receive['data'][0][0])), dtype=PyCtxt)
d = receive['data']
for i in range(len(d)):
    for j in range(len(d[i])):
        for k in range(len(d[i][j])):
            data[i][j][k] = PyCtxt(pyfhel=trainer, bytestring=d[i][j][k].encode('cp437'))
    
labels = np.ndarray(shape=(len(receive['labels'])), dtype=PyCtxt)
for i in range(len(receive['labels'])):
    labels[i] = PyCtxt(pyfhel=trainer, bytestring=receive['labels'][i].encode('cp437'))

print(data.shape, labels.shape)

