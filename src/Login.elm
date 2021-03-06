module Login exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Form.Input as Input
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Msgs exposing (..)

view : String -> Html Msg
view email =
  div []
  [ Input.email [ Input.onInput UpdateEmail ]
  , Button.button
    [ Button.onClick (if email == "" then NoOp else Login)
    , Button.dark
    , Button.attrs
      [ style "width" "100%"
      , style "margin-top" "10px"
      ]
    ]
    [ text "Login" ]
  ]
