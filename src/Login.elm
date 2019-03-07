module Login exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Form.Input as Input
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msgs exposing (..)

view : Html Msg
view =
  div []
  [ Input.email
    [ Input.attrs
      [ onInput UpdateEmail
      , placeholder "Email" ]
    ]
  , Button.button
    [ Button.primary
    , Button.attrs
      [ onClick Login
      , style "width" "100%"
      , style "margin-top" "10px"
      ]
    ]
    [ text "Login" ]
  ]
