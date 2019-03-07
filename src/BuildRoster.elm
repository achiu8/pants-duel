module BuildRoster exposing (..)

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
    , Select.select
      [ Select.attrs
        [ onInput selectCategory
        , style "width" "100%"
        , style "margin" "10px 0"
        ]
      ]
      (List.map (selectOption << categoryDisplay) categories)
    , ProductList.view model model.products False
    ]

selectOption : String -> Select.Item Msg
selectOption v =
  Select.item [] [ text v ]

