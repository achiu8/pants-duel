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
  | ReceivedInitial (Result Http.Error Initial)
  | ReceivedRoster (Result Http.Error (List Product))
  | SubmitRoster
  | FetchResults
  | ReceivedResults (Result Http.Error (List User))
  | CheckSubmitted
  | NoOp

selectCategory : String -> Msg
selectCategory = SelectCategory << categoryFromString
