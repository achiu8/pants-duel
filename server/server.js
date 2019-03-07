const express = require('express')
const cors = require('cors')
const bodyParser = require('body-parser')
const products = require('./products')
const results = require('./results')
const score = require('./score')

const app = express()

let submittedResults = []

app.use(cors())
app.use(bodyParser.json())

app.get('/products', (req, res) => {
  res.json({ data: { allProducts: products } })
})

app.get('/results', (req, res) => {
  res.json({ data: { allRosters: [...results(), ...submittedResults] } })
})

app.post('/roster', (req, res) => {
  submittedResults.push({ ...req.body, score: score() })
  res.json({ data: { allRosters: [...results(), ...submittedResults] } })
})

app.listen(9000, () => console.log('listening...'))
