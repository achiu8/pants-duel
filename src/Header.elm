module Header exposing (..)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Text as Text
import FontAwesome.Icon as Icon
import FontAwesome.Solid as Icon
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Models exposing (..)
import Msgs exposing (..)

view : List (Html Msg) -> Html Msg
view right =
  Grid.row []
    [ Grid.col []
      [ div [ onClick (View Home), style "cursor" "pointer" ]
        [ Icon.viewStyled [ style "margin-right" "10px" ] Icon.chevronLeft
        , text "Back to Home" ]
        ]
    , Grid.col [ Col.textAlign Text.alignXsRight ] right
    ]
