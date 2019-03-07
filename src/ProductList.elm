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
