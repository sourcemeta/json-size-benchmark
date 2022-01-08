import sys
from thrift.protocol import TCompactProtocol
from thrift.transport import TTransport
import schema.ttypes
import json
import run

with open(sys.argv[1]) as json_data:
    data = json.load(json_data)

result = run.encode(data, schema.ttypes)
transportOut = TTransport.TMemoryBuffer()
protocolOut = TCompactProtocol.TCompactProtocol(transportOut)
result.write(protocolOut)
bytes = transportOut.getvalue()

fd = open(sys.argv[2], 'wb')
fd.write(bytes)
fd.close()
