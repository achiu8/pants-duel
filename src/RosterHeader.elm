module RosterHeader exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Header exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Utils exposing (..)

view : Model -> Html Msg
view model =
  div []
    [ Header.view [ text ("Budget Left: " ++ currency (budgetLeft model.roster)) ]
    , div [ style "text-align" "center" ]
      [ text ("Roster Spots Filled: " ++ String.fromInt (List.length model.roster)) ]
    ]
