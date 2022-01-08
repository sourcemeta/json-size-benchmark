const fs = require('fs')
const BSON = require('bson')

const buffer = fs.readFileSync(process.argv[2])

const deserialize = (buffer) => {
  return BSON.deserialize(buffer)
}

console.log(JSON.stringify(deserialize(buffer), null, 2))
