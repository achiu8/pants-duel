module Msgs exposing (..)

import Models exposing (..)
import Utils exposing (..)

type Msg
  = View Page
  | SelectCategory Category
  | SelectProduct Product
  | RemoveProduct Product
  | SubmitRoster
  | NoOp

selectCategory : String -> Msg
selectCategory = SelectCategory << categoryFromString
