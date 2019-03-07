module BuildRoster exposing (..)

import Bootstrap.Form.Select as Select
import Dict exposing (..)
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
  let counts = countCategories model.roster
  in
  div []
    [ RosterHeader.view model
    , Select.select
      [ Select.attrs
        [ onInput selectCategory
        , style "width" "100%"
        , style "margin" "10px 0"
        ]
      ]
      (List.map (selectOption counts model.category << categoryDisplay) categories)
    , ProductList.view model model.products False
    ]

selectOption : Dict String Int -> Category -> String -> Select.Item Msg
selectOption counts selectedCategory category =
  let count = String.fromInt (Maybe.withDefault 0 (Dict.get category counts))
  in
  Select.item
    [ value category
    , selected (category == categoryDisplay selectedCategory)
    ]
    [ text (category ++ " (" ++ count ++ ")") ]
