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

import Commands exposing (..)
import Home exposing (..)
import Login exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Roster exposing (..)
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
  (initialModel, fetchProducts)

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

view : Model -> Html Msg
view model =
  Grid.container [ style "max-width" "600px" ]
    [ CDN.stylesheet
    , Icon.css
    , div [ style "text-align" "center" ]
      [ img
        [ src "https://s3-us-west-1.amazonaws.com/static-friendbuy-com/widget/bonobos/landing/img/logo.png"
        , style "width" "80%"
        , style "margin" "25px 0"
        ] []
      ]
    , contents model
    ]

contents : Model -> Html Msg
contents model =
  if not model.loggedIn
    then Login.view
    else case model.page of
           Home -> Home.view
           Roster -> Roster.view model
