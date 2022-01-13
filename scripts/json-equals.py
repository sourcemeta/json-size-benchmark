import sys
import json

with open(sys.argv[1], mode='r') as json_data:
    data1 = json.loads(json_data.read())

with open(sys.argv[2], mode='r') as json_data:
    data2 = json.loads(json_data.read())

if data1 == data2:
    print("Files are equal!")
    sys.exit(0)
else:
    print("Files are NOT equal!")
    print(json.dumps(data1, indent=4))
    print(json.dumps(data2, indent=4))
    sys.exit(1)
