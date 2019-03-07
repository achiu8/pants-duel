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

introText : String
introText = "Welcome to PantsDuel - the most exciting way to learn about Bonobos product assortment and sales metrics!"

panels : List Panel
panels =
  [ Panel (View BuildRoster) "Build Your Daily Roster"
  , Panel (View ViewRoster) "View / Submit Your Daily Roster"
  , Panel (View Results) "View Last Game Results"
  , Panel NoOp "Leaderboard"
  ]

view : Html Msg
view =
  div []
    (p [] [ text introText ] :: List.map panel panels)

panel : Panel -> Html Msg
panel p =
  div
    [ onClick p.onClick
    , style "line-height" "75px"
    , style "border-top" "1px solid grey"
    ]
    [ Grid.row []
      [ Grid.col [ Col.middleXs ]
        [ div [] [ text p.text ] ]
      , Grid.col [ Col.middleXs, Col.textAlign Text.alignXsRight ]
        [ Icon.viewStyled [ Icon.lg ] Icon.chevronRight ]
      ]
    ]
