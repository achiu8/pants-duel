module Home exposing (..)

import Html exposing (..)
import Html.Events exposing (..)

import Models exposing (..)
import Msgs exposing (..)
import Types exposing (..)

view : Html Msg
view =
  div []
    [ p [] [ text "Welcome to PantsDuel" ]
    , div [ onClick (View Roster) ] [ text "Build Your Daily Roster" ]
    , div [ onClick (View Roster) ] [ text "View / Submit Your Daily Roster" ]
    , div [] [ text "View Yesterday's Results" ]
    , div [] [ text "Leaderboard" ]
    ]
