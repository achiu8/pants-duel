import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Browser
import FontAwesome.Styles as Icon
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time

import BuildRoster exposing (..)
import Commands exposing (..)
import Home exposing (..)
import Login exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Results exposing (..)
import Update exposing (..)
import ViewRoster exposing (..)

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

init : () -> (Model, Cmd Msg)
init _ =
  (initialModel, fetchInitial)

subscriptions : Model -> Sub Msg
subscriptions _ =
  Time.every 5000 (always FetchResults)

view : Model -> Html Msg
view model =
  Grid.container [ style "max-width" "600px" ]
    [ CDN.stylesheet
    , Icon.css
    , div [ style "text-align" "center" ]
      [ img
        [ src "https://s3-us-west-1.amazonaws.com/static-friendbuy-com/widget/bonobos/landing/img/logo.png"
        , style "width" "80%"
        , style "margin" "50px 0"
        ] []
      ]
    , contents model
    ]

contents : Model -> Html Msg
contents model =
  if not model.loggedIn
    then Login.view model.email
    else case model.page of
           Home -> Home.view
           BuildRoster -> BuildRoster.view model
           ViewRoster -> ViewRoster.view model
           Results -> Results.view model Current
           Previous -> Results.view model Last
