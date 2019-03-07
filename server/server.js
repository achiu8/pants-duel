const express = require('express')
const cors = require('cors')
const products = require('./products')
const leaderboard = require('./leaderboard')

const app = express()

app.use(cors())

app.get('/products', (req, res) => {
  res.json({ products })
})

app.get('/leaderboard', (req, res) => {
  res.json({ leaderboard })
})

app.listen(9000, () => console.log('listening...'))
