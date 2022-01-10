import sys
import bson
import json

with open(sys.argv[1], mode='rb') as ubjson_data:
    data = bson.BSON(ubjson_data.read()).decode()

print(json.dumps(data, indent=4))
