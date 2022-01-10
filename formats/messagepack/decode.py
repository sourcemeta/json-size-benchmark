import sys
import msgpack
import json

with open(sys.argv[1], mode='rb') as msgpack_data:
    data = msgpack.unpackb(msgpack_data.read())

print(json.dumps(data, indent=4))
