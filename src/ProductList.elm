module ProductList exposing (..)

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
    |> (::) (text (if model.submitted then "Your roster has been submitted for today. Check results at 5pm." else ""))
    |> div [ style "overflow" "auto", style "height" "450px" ]

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
  div [ style "padding" "10px 0", style "border-bottom" "1px solid grey" ]
    [ Grid.row []
      [ Grid.col [ Col.xs3 ]
        [ img [ src (categoryImage product.category) , style "height" "100px" ] []
        ]
      , Grid.col [ Col.middleXs, Col.xs6 ]
        [ div []
          [ div [] [ text product.name ]
          , div [] [ text (currency product.price) ]
          ]
        ]
      , Grid.col [ Col.middleXs, Col.textAlign Text.alignXsRight ]
        [ div [ onClick (action product), style "padding-right" "10px" ]
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
