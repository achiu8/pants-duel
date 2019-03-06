import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Browser
import FontAwesome.Styles as Icon
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, field, string)
import Task
import Time

import Home exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Roster exposing (..)
import Types exposing (..)
import Update exposing (..)

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

init : () -> (Model, Cmd Msg)
init _ =
  (initialModel, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

view : Model -> Html Msg
view model =
  Grid.container [ style "max-width" "600px" ]
    [ CDN.stylesheet
    , Icon.css
    , h1 [] [ text "Bonobos" ]
    , contents model
    ]

contents : Model -> Html Msg
contents model =
  case model.page of
    Home -> Home.view
    Roster -> Roster.view model
