const fs = require('fs')
const uncompressed = process.argv[2]

const result = process.argv.slice(5).reduce((accumulator, compressor) => {
  accumulator.data[compressor] = fs.statSync(`${uncompressed}.${compressor}`).size
  return accumulator
}, {
  format: process.argv[3],
  version: process.argv[4],
  data: {
    uncompressed: fs.statSync(uncompressed).size
  }
})

console.log(JSON.stringify(result, null, 2))
