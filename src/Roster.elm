module Roster exposing (..)

import Bootstrap.Button as Button
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
import Utils exposing (..)

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
      [ onInput selectCategory
      , style "width" "100%"
      ]
      (List.map (selectOption << categoryDisplay) categories)
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
      selectable = budgetLeft roster >= product.price
      action = if selected
                 then RemoveProduct
                 else if selectable
                   then SelectProduct
                   else (always NoOp)
  in
  div [ style "margin-top" "20px" ]
    [ Grid.row []
      [ Grid.col []
        [ img [ src (categoryImage product.category) , style "height" "100px" ] []
        ]
      , Grid.col [ Col.middleMd ]
        [ div []
          [ div [] [ text product.name ]
          , div [] [ text (String.fromInt product.price) ]
          ]
        ]
      , Grid.col [ Col.middleMd, Col.textAlign Text.alignMdRight ]
        [ div [ onClick (action product) ]
          [ if selected
              then Icon.viewStyled [ Icon.fa2x, style "color" "Green" ] Icon.checkCircle
              else Icon.viewStyled
                     [ Icon.fa2x
                     , style "color" (if selectable then "black" else "lightgrey")
                     ]
                     Icon.plusCircle
          ]
        ]
      ]
    ]
