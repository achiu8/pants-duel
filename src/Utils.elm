module Utils exposing (..)

import Models exposing (..)

budgetLeft : List Product -> Int
budgetLeft = List.foldr (\p left -> left - p.price) 20
