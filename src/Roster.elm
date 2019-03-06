module Roster exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Grid as Grid
import FontAwesome.Attributes as Icon
import FontAwesome.Icon as Icon
import FontAwesome.Solid as Icon
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Models exposing (..)
import Msgs exposing (..)
import Styles exposing (..)
import Types exposing (..)
import Utils exposing (..)

categories : List String
categories =
  [ "bottoms"
  , "tops"
  , "outerwear"
  , "suits"
  , "accessories"
  ]

view : Model -> Html Msg
view model =
  div []
    [ div [ onClick (View Home) ] [ text "Back to Home" ]
    , div [] [ text ("Budget Left: " ++ String.fromInt (budgetLeft model.roster)) ]
    , div [] [ text ("Slots filled: " ++ String.fromInt (List.length model.roster)) ]
    , div []
      [ Button.button
        [ Button.primary
        , Button.attrs
          [ onClick SubmitRoster
          , style "width" "100%"
          ]
        ]
        [ text "Submit Roster" ]
      ]
    , select
      [ onInput SelectCategory
      , style "width" "100%"
      ]
      (List.map selectOption categories)
    , productsList model
    ]

selectOption : String -> Html Msg
selectOption v =
  option [] [ text v ]

productsList : Model -> Html Msg
productsList model =
  model.products
    |> List.filter (\p -> p.category == model.category)
    |> List.map (productRow model.roster)
    |> div []

productRow : List Product -> Product -> Html Msg
productRow roster product =
  let selected = List.member product roster
      action = if selected then RemoveProduct else SelectProduct
  in
  Grid.row []
    [ Grid.col []
      [ img
        [ src "https://png.pngtree.com/svg/20170804/7007aea49e.svg"
        , style "height" "100px"
        ]
        []
      ]
    , Grid.col []
      [ div
        [ style "position" "relative"
        , style "top" "50%"
        , style "transform" "translateY(-50%)"
        ]
        [ div [] [ text product.name ]
        , div [] [ text (String.fromInt product.price) ]
        ]
      ]
    , Grid.col []
      [ div [ onClick (action product), style "line-height" "100px" ]
        [ if selected
          then Icon.viewStyled [ Icon.fa2x, style "color" "Green" ] Icon.checkCircle
          else Icon.viewStyled [ Icon.fa2x ] Icon.plusCircle
        ]
      ]
    ]
