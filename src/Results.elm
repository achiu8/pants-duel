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
      results = if game == Current then model.results else model.results
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
        , Table.th [ cellCenter ] [ text "Score" ]
        ]
      , tbody = Table.tbody [] (List.indexedMap (resultRow found) (current ++ sorted))
      }
    ]

resultRow : Bool -> Int -> (Int, User) -> Table.Row Msg
resultRow found i (rank, user) =
  Table.tr (if found && i == 0 then [ Table.rowActive ] else [])
    [ Table.td [ cellCenter ] [ text (String.fromInt (rank + 1)) ]
    , Table.td [] [ text user.email ]
    , Table.td [ cellCenter ] [ text (String.fromInt user.score) ]
    ]

sortWithRank : List User -> List (Int, User)
sortWithRank = List.indexedMap Tuple.pair << List.reverse << List.sortBy .score

center : Attribute Msg
center = style "text-align" "center"

cellCenter : Table.CellOption Msg
cellCenter = Table.cellAttr center
