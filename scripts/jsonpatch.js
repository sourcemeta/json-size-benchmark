const fs = require('fs')
const jsonpatch = require('fast-json-patch')
const chunks = []

process.stdin.resume()
process.stdin.setEncoding('utf8')
process.stdin.on('data', (chunk) => {
  chunks.push(chunk)
})

function applyPatch (document, patch) {
  return jsonpatch.applyPatch(document, patch, false, false).newDocument
}

process.stdin.on('end', () => {
  const document = JSON.parse(chunks.join())
  const patch = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'))
  console.log(JSON.stringify(applyPatch(document, patch), null, 2))
})
