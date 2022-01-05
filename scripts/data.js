const fs = require('fs')
const path = require('path')

const data = process.argv.slice(3).reduce((accumulator, filePath) => {
  accumulator.push(JSON.parse(fs.readFileSync(filePath, 'utf8')))
  return accumulator
}, []).sort((left, right) => {
  return left.data.uncompressed - right.data.uncompressed
})

const result = {
  document: process.argv[2],
  labels: data.map((entry) => {
    return entry.format
  }),

  // Uncompressed always comes first
  datasets: ['uncompressed'].concat(Object.keys(data[0].data).filter((compressor) => {
    return compressor !== 'uncompressed'
  }).sort()).map((compressor) => {
    return {
      title: compressor === 'uncompressed'
        ? 'Uncompressed'
        : fs.readFileSync(path.resolve('compression', compressor, 'NAME'), 'utf8').trim(),
      data: data.map((entry) => {
        return entry.data[compressor]
      })
    }
  })
}

console.log(JSON.stringify(result, null, 2))
