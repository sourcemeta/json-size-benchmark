import sys
import json
import jsonpatch

with open(sys.argv[1]) as json_data:
    document = json.load(json_data)

with open(sys.argv[2]) as json_data:
    patch = jsonpatch.JsonPatch(json.load(json_data))

result = patch.apply(document)
print(json.dumps(result, indent=4))
