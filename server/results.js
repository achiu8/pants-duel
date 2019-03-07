const products = require('./products')

const buildRoster = () =>
  Array(5).fill(null)
    .map(_ => products[Math.floor(Math.random() * products.length)])

const users = [
  'alice@bonobos.com',
  'bob@bonobos.com',
  'chris@bonobos.com',
  'dave@bonobos.com',
  'emily@bonobos.com',
]

module.exports = () =>
  users.map(email => ({
    email,
    roster: buildRoster(),
    score: Math.floor(Math.random() * 500)
  }))
