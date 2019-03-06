module Msgs exposing (..)

import Models exposing (..)
import Types exposing (..)

type Msg
  = View Page
  | SelectCategory String
  | SelectProduct Product
  | RemoveProduct Product
  | SubmitRoster
