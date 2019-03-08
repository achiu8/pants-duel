module Queries exposing (..)

import Json.Encode exposing (..)

import Json exposing (..)
import Models exposing (..)

query : String -> Value
query q = object [("query", string q)]

queryWithVariable : String -> Value -> String -> Value
queryWithVariable name value q =
  object
    [ ("query", string q)
    , ("variables", object [(name, value)])
    ]

rosterQuery : String -> Value
rosterQuery email = queryWithVariable "userName" (string email) """
  query($userName: String) {
    roster(userName: $userName) {
      products {
        id
        productName
        productPrice
        productCategory
        productScores {
          productScore
        }
      }
    }
  }
"""

createRosterQuery : Model -> Value
createRosterQuery model = queryWithVariable "input" (rosterEncoder model) """
  mutation($input: RosterInput!) {
    createRoster(input: $input) {
      roster {
        userName
        finalScore
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
      productScores {
        productScore
      }
    }
  }
"""

resultsQuery : Value
resultsQuery = query """
  {
    currentRosters {
      userName
      finalScore
      products {
        id
        productName
        productPrice
        productCategory
        productScores {
          productScore
        }
      }
    }
  }
"""
