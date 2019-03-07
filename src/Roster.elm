module Roster exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Form.Select as Select
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Header exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import ProductList exposing (..)
import Utils exposing (..)

view : Model -> Html Msg
view model =
  div []
    [ Header.view [ text ("Budget Left: " ++ currency (budgetLeft model.roster)) ]
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

selectOption : String -> Select.Item Msg
selectOption v =
  Select.item [] [ text v ]

