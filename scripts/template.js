const fs = require('fs')
const handlebars = require('handlebars')

handlebars.registerHelper('ifnot', function ifnot (left, right, options) {
  return left === right
    ? options.inverse(this)
    : options.fn(this)
})

handlebars.registerHelper('year', () => {
  return (new Date()).getFullYear()
})

handlebars.registerHelper('stringify', (value) => {
  return JSON.stringify(value, null, 2)
})

handlebars.registerHelper('item', (array, index) => {
  return array[parseInt(index, 10)]
})

handlebars.registerHelper('capitalize', (string) => {
  return string[0].toUpperCase() + string.slice(1)
})

handlebars.registerHelper('timestamp', () => {
  return (new Date()).toLocaleDateString('en-CA')
})

const template = fs.readFileSync(process.argv[2], 'utf8')
const data = JSON.parse(fs.readFileSync(process.argv[3], 'utf8'))
const output = handlebars.compile(template)({
  curlyLeft: '{',
  curlyRight: '}',
  env: process.env,
  data
})
console.log(output)
