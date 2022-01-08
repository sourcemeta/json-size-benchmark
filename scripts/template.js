const fs = require('fs')
const handlebars = require('handlebars')
require('handlebars-helpers')({ handlebars })
const packageJSON = require('../package.json')

const template = fs.readFileSync(process.argv[2], 'utf8')
const data = JSON.parse(fs.readFileSync(process.argv[3], 'utf8'))
const output = handlebars.compile(template)({
  metadata: packageJSON,
  data,

  timestamp: () => {
    return (new Date()).toLocaleDateString('en-CA')
  }
})
console.log(output)
