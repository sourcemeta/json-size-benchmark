import sys
import bson
import json

with open(sys.argv[1], mode='rb') as binary_data:
    data = bson.BSON(binary_data.read()).decode()

print(json.dumps(data, indent=4))
