module Queries exposing (..)

import Json.Encode exposing (..)

query : String -> Value
query q = object [("query", string q)]

queryWithVariable : String -> String -> String -> Value
queryWithVariable name value q =
  object
    [ ("query", string q)
    , ("variables", object [(name, string value)])
    ]

rosterQuery : String -> Value
rosterQuery email = queryWithVariable "userName" email """
  query($userName: String) {
    roster(userName: $userName) {
      products {
        id
        productName
        productPrice
        productCategory
      }
    }
  }
"""

productsQuery : Value
productsQuery = query """
  {
    allProducts {
      id
      productName
      productPrice
      productCategory
    }
  }
"""

resultsQuery : Value
resultsQuery = query """
  {
    allRosters {
      userName
      finalScore
    }
  }
"""
