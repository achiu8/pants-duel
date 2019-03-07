module ViewRoster exposing (..)

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
    , ProductList.view model model.roster True
    , if List.length model.roster == 0
        then text "You haven't drafted any products."
        else text ""
    ]

selectOption : String -> Select.Item Msg
selectOption v =
  Select.item [] [ text v ]

