module Queries exposing (..)

import Json.Encode exposing (..)

query : String -> Value
query q = object [("query", string q)]

productsQuery : Value
productsQuery = query """
  {
    allProducts {
      productName
      productPrice
      productCategory
    }
  }
"""
