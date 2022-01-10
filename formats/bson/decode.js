const fs = require('fs')
const BSON = require('bson')

const buffer = fs.readFileSync(process.argv[2])
console.log(JSON.stringify(BSON.deserialize(buffer), null, 2))
