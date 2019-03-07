module Msgs exposing (..)

import Http

import Models exposing (..)
import Utils exposing (..)

type Msg
  = View Page
  | Login
  | UpdateEmail String
  | SelectCategory Category
  | SelectProduct Product
  | RemoveProduct Product
  | ReceivedProducts (Result Http.Error (List Product))
  | ReceivedResults (Result Http.Error (List User))
  | SubmitRoster
  | NoOp

selectCategory : String -> Msg
selectCategory = SelectCategory << categoryFromString
