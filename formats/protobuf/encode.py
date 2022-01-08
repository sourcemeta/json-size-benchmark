import sys
import json
import schema_pb2
import run

with open(sys.argv[1]) as json_data:
    data = json.load(json_data)

result = run.encode(data, schema_pb2)

fd = open(sys.argv[2], 'wb')
fd.write(result.SerializeToString())
fd.close()
