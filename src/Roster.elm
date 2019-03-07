module Roster exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Form.Select as Select
import Bootstrap.Text as Text
import FontAwesome.Icon as Icon
import FontAwesome.Solid as Icon
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Models exposing (..)
import Msgs exposing (..)
import ProductList exposing (..)
import Utils exposing (..)

view : Model -> Html Msg
view model =
  div []
    [ header (currency (budgetLeft model.roster))
    , div [ style "text-align" "center" ]
      [ text ("Roster spots filled: " ++ String.fromInt (List.length model.roster)) ]
    , div []
      [ Button.button
        [ Button.dark
        , Button.attrs
          [ onClick SubmitRoster
          , style "width" "100%"
          , style "margin" "10px 0"
          ]
        ]
        [ text "Submit Roster" ]
      ]
    , Select.select
      [ Select.attrs
        [ onInput selectCategory
        , style "width" "100%"
        ]
      ]
      (List.map (selectOption << categoryDisplay) categories)
    , ProductList.view model
    ]

header : String -> Html Msg
header budget =
  Grid.row []
    [ Grid.col []
      [ div [ onClick (View Home) ]
        [ Icon.viewStyled [ style "margin-right" "10px" ] Icon.chevronLeft
        , text "Back to Home" ]
        ]
    , Grid.col [ Col.textAlign Text.alignXsRight ]
      [ div [] [ text ("Budget Left: " ++ budget) ] ]
    ]

selectOption : String -> Select.Item Msg
selectOption v =
  Select.item [] [ text v ]

