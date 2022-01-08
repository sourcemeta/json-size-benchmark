import sys
import json
import schema_pb2
import run

with open(sys.argv[1], mode='rb') as binary_data:
    data = binary_data.read()

payload = schema_pb2.Main()
payload.ParseFromString(data)

fd = open(sys.argv[2], 'w')
fd.write(json.dumps(run.decode(payload), indent=4))
fd.close()
