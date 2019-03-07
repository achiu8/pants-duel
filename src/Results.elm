module Results exposing (..)

import Bootstrap.General.HAlign as Align
import Bootstrap.Table as Table
import Html exposing (..)
import Html.Attributes exposing (..)

import Models exposing (..)
import Msgs exposing (..)

view : Model -> Html Msg
view model =
  Table.table
  { options = [ Table.striped ]
  , thead = Table.simpleThead
    [ Table.th [ center ] [ text "User" ]
    , Table.th [ center ] [ text "Score" ]
    ]
  , tbody = Table.tbody [] (List.map resultRow model.results)
  }

resultRow : User -> Table.Row Msg
resultRow user =
  Table.tr []
    [ Table.td [] [ text user.email ]
    , Table.td [ center ] [ text "100" ]
    ]

center : Table.CellOption Msg
center = Table.cellAttr (style "text-align" "center")
