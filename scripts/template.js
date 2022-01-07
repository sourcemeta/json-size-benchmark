const fs = require('fs')
const handlebars = require('handlebars')
require('handlebars-helpers')({ handlebars })
const template = fs.readFileSync(process.argv[2], 'utf8')
const data = JSON.parse(fs.readFileSync(process.argv[3], 'utf8'))
const output = handlebars.compile(template)({
  data
})
console.log(output)
