const fs = require('fs')

console.log(JSON.stringify(process.argv.slice(2).reduce((accumulator, value) => {
  accumulator.push(JSON.parse(fs.readFileSync(value, 'utf8')))
  return accumulator
}, []), null, 2))
