const express = require('express')
const cors = require('cors')
const bodyParser = require('body-parser')
const products = require('./products')
const results = require('./results')

const app = express()

let currentResults = [...results]

app.use(cors())
app.use(bodyParser.json())

app.get('/products', (req, res) => {
  res.json({ products })
})

app.get('/results', (req, res) => {
  res.json({ results: currentResults })
})

app.post('/roster', (req, res) => {
  currentResults.push(req.body)
  res.json({ results: currentResults })
})

app.listen(9000, () => console.log('listening...'))
