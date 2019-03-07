module Results exposing (..)

import Bootstrap.General.HAlign as Align
import Bootstrap.Table as Table
import Html exposing (..)
import Html.Attributes exposing (..)

import Header exposing (..)
import Models exposing (..)
import Msgs exposing (..)

view : Model -> Html Msg
view model =
  div []
    [ Header.view  []
    , h3 [ center, style "margin-bottom" "20px" ] [ text "Yesterday's Results" ]
    , Table.table
      { options = [ Table.striped ]
      , thead = Table.simpleThead
        [ Table.th [ cellCenter ] [ text "User" ]
        , Table.th [ cellCenter ] [ text "Score" ]
        ]
      , tbody = Table.tbody [] (List.map resultRow model.results)
      }
    ]

resultRow : User -> Table.Row Msg
resultRow user =
  Table.tr []
    [ Table.td [] [ text user.email ]
    , Table.td [ cellCenter ] [ text "100" ]
    ]

center : Attribute Msg
center = style "text-align" "center"

cellCenter : Table.CellOption Msg
cellCenter = Table.cellAttr center
