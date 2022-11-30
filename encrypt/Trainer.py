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

data = []
for i in receive['data']:
    data.append(PyCtxt(pyfhel=trainer, bytestring=i.encode('cp437')))
    
print(data[0])


