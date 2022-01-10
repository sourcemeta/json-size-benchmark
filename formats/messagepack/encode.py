import sys
import msgpack
import json

with open(sys.argv[1]) as json_data:
    data = json.load(json_data)

fd = open(sys.argv[2], "wb")
fd.write(msgpack.packb(data))
fd.close()
