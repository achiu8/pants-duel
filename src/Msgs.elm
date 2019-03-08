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
  | ReceivedRoster (Result Http.Error (List Product))
  | ReceivedProducts (Result Http.Error (List Product))
  | FetchResults
  | ReceivedResults (Result Http.Error (List User))
  | ReceivedPrevious (Result Http.Error (List User))
  | SubmitRoster
  | CheckSubmitted
  | NoOp

selectCategory : String -> Msg
selectCategory = SelectCategory << categoryFromString
