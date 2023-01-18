const express = require('express')
const morgan = require('morgan')

const app = express()
const port = 3000

app.set('view engine', 'ejs')
app.set('trust proxy', true)
app.use(morgan('combined'))

const { STATUS_CODES } = require('http')

const homeUrl = process.env.HOME_URL || 'https://example.com'

const rangeErrorMessages = {
  4: 'Looks like you made a wrong turn.',
  5: 'Our bad. We\'ll get it fixed soon.'
}

app.get('/:code?', (req, res) => {
  let code = parseInt(req.params.code)
  if (!STATUS_CODES[code]) {
    code = 404
  }

  const codeTrim = code.toString().substring(0, 1)

  res.status(code).render('index.ejs', { errorNo: code, errorDesc: STATUS_CODES[code], prettyDesc: rangeErrorMessages[codeTrim], homeUrl })
})

app.listen(port, () => {
  console.log(`simple-errors app listening on port ${port}`)
})
