module Results exposing (..)

import Bootstrap.Table as Table
import Html exposing (..)
import Html.Attributes exposing (..)

import Header exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Utils exposing (..)

view : Model -> Game -> Html Msg
view model game =
  let title = if game == Current then "Current" else "Previous"
      results = if game == Current then model.results else model.previous
      sorted = sortWithRank results
      current = List.filter (\(_, user) -> user.email == model.email) sorted
      found = not (List.isEmpty current)
  in
  div []
    [ Header.view  []
    , h3 [ center, style "margin-bottom" "20px" ]
      [ text (title ++ " Game Results") ]
    , Table.table
      { options = [ Table.hover ]
      , thead = Table.simpleThead
        [ Table.th [ cellCenter ] [ text "Rank" ]
        , Table.th [ cellCenter ] [ text "User" ]
        , Table.th [ cellCenter ] [ text "B" ]
        , Table.th [ cellCenter ] [ text "T" ]
        , Table.th [ cellCenter ] [ text "O" ]
        , Table.th [ cellCenter ] [ text "S" ]
        , Table.th [ cellCenter ] [ text "A" ]
        , Table.th [ cellCenter ] [ text "Total" ]
        ]
      , tbody = Table.tbody [] (List.indexedMap (resultRow found) (current ++ sorted))
      }
    ]

resultRow : Bool -> Int -> (Int, User) -> Table.Row Msg
resultRow found i (rank, user) =
  Table.tr
    (
      if found && i == 0
        then [ Table.rowActive
             , Table.rowAttr (style "border-bottom" "2px solid grey")
             ]
        else []
    )
    (
      [ Table.td [ cellCenter ] [ intHtml (rank + 1) ]
      , Table.td [] [ text user.email ]
      ]
      ++
      List.map scoreCell (categoryScores user.products)
      ++
      [ Table.td [ cellCenter ] [ intHtml (totalScore user) ] ]
    )

sortWithRank : List User -> List (Int, User)
sortWithRank = List.indexedMap Tuple.pair << List.reverse << List.sortBy totalScore

center : Attribute Msg
center = style "text-align" "center"

cellCenter : Table.CellOption Msg
cellCenter = Table.cellAttr center

categoryScores : List Product -> List Int
categoryScores products = List.map (categoryScore products) categories

categoryScore : List Product -> Category -> Int
categoryScore products category =
  products
    |> List.filter (\p -> p.category == category)
    |> List.foldr (\p acc -> acc + p.score) 0

totalScore : User -> Int
totalScore = List.foldr (+) 0 << categoryScores << .products

scoreCell : Int -> Table.Cell Msg
scoreCell score = Table.td [ cellCenter ] [ intHtml score ]

intHtml : Int -> Html Msg
intHtml = text << String.fromInt
