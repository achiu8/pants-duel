module ProductList exposing (..)

import Bootstrap.Alert as Alert
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

view : Model -> List Product -> Bool -> Html Msg
view model products all =
  products
    |> List.filter (\p -> p.category == model.category || all)
    |> List.map (productRow model)
    |> (::) (if model.submitted then submittedMessage else text "")
    |> div [ style "overflow" "auto" ]

submittedMessage : Html Msg
submittedMessage =
  Alert.simpleSecondary [ style "margin" "10px 0" ]
    [ text "Your roster has been submitted for today. View the "
    , span
      [ onClick (View Results)
      , style "text-decoration" "underline"
      , style "cursor" "pointer"
      ]
      [ text "current game" ]
    , text "."
    ]

productRow : Model -> Product -> Html Msg
productRow model product =
  let selected = List.member product model.roster
      selectable = budgetLeft model.roster >= product.price
      action = if model.submitted
                 then (always NoOp)
                 else if selected
                   then RemoveProduct
                   else if selectable
                     then SelectProduct
                     else (always NoOp)
  in
  div [ onClick (action product)
      , style "padding" "10px 0"
      , style "border-bottom" "1px solid grey"
      , style "cursor" "pointer"
      ]
    [ Grid.row []
      [ Grid.col [ Col.xs3 ]
        [ img
          [ src (categoryImage product.category)
          , style "width" "100%"
          , style "max-height" "100px"
          ]
          []
        ]
      , Grid.col [ Col.xs7, Col.middleXs ]
        [ div []
          [ div [] [ text product.name ]
          , div [] [ text (currency product.price) ]
          ]
        ]
      , Grid.col [ Col.xs2, Col.middleXs, Col.textAlign Text.alignXsRight ]
        [ div [ style "padding-right" "10px" ]
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
