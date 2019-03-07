module Home exposing (..)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Text as Text
import FontAwesome.Attributes as Icon
import FontAwesome.Icon as Icon
import FontAwesome.Solid as Icon
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Models exposing (..)
import Msgs exposing (..)

type alias Panel =
  { onClick : Msg
  , text : String
  }

panels : List Panel
panels =
  [ Panel (View Roster) "Build Your Daily Roster"
  , Panel (View Roster) "View / Submit Your Daily Roster"
  , Panel NoOp "View Yesterday's Results"
  , Panel NoOp "Leaderboard"
  ]

view : Html Msg
view =
  div []
    (p [] [ text "Welcome to PantsDuel" ] :: List.map panel panels)

panel : Panel -> Html Msg
panel p =
  div [ onClick p.onClick , style "margin-top" "20px" ]
    [ Grid.row []
      [ Grid.col [ Col.middleMd ]
        [ div [] [ text p.text ] ]
      , Grid.col [ Col.middleMd, Col.textAlign Text.alignMdRight ]
        [ Icon.viewStyled [ Icon.lg ] Icon.chevronRight ]
      ]
    ]
