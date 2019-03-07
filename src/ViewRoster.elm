module ViewRoster exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Form.Select as Select
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Models exposing (..)
import Msgs exposing (..)
import ProductList exposing (..)
import RosterHeader exposing (..)
import Utils exposing (..)

view : Model -> Html Msg
view model =
  div []
    [ RosterHeader.view model
    , div []
      [ Button.button
        [ Button.onClick SubmitRoster
        , Button.disabled (model.submitted || not (validRoster model.roster))
        , Button.dark
        , Button.attrs
          [ style "width" "100%"
          , style "margin" "10px 0"
          ]
        ]
        [ text (if model.submitted then "Roster Submitted" else "Submit Roster") ]
      ]
    , if List.length model.roster == 0
        then text "You haven't drafted any products."
        else ProductList.view model model.roster True
    ]

selectOption : String -> Select.Item Msg
selectOption v =
  Select.item [] [ text v ]

