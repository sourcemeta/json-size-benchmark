const fs = require('fs')
const path = require('path')
const name = process.argv[2]
const files = process.argv.slice(3)

const data = []

for (const file of files) {
  const content = JSON.parse(fs.readFileSync(file, 'utf8'))
  data.push(content)
}

const sorted = data.sort((a, b) => {
  return a.data.uncompressed - b.data.uncompressed
})

console.log(sorted)

const labels = sorted.map((entry) => {
  return entry.format
})

console.log({
  document: name,
  labels,
  datasets: []
})
