const express = require('express')
const cors = require('cors')
const products = require('./products')
const results = require('./results')

const app = express()

app.use(cors())

app.get('/products', (req, res) => {
  res.json({ products })
})

app.get('/results', (req, res) => {
  res.json({ results })
})

app.listen(9000, () => console.log('listening...'))
