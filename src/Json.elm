module Json exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Json.Encode as Encode exposing (..)

import Models exposing (..)
import Utils exposing (..)

productDecoder : Decoder Product
productDecoder =
  Decode.succeed Product
   |> required "id" Decode.string
   |> required "productName" Decode.string
   |> required "productCategory" (Decode.map categoryFromString Decode.string)
   |> required "productPrice" Decode.int

productsDecoder : Decoder (List Product)
productsDecoder =
  Decode.list productDecoder
    |> Decode.field "allProducts"
    |> Decode.field "data"

productEncoder : Product -> Encode.Value
productEncoder product =
  object
    [ ("id", Encode.string product.id)
    , ("productName", Encode.string product.name)
    , ("productCategory", Encode.string (categoryDisplay product.category))
    , ("productPrice", Encode.int product.price)
    ]

rosterEncoder : Model -> Encode.Value
rosterEncoder model =
  object
    [ ("email", Encode.string model.email)
    , ("roster", Encode.list productEncoder model.roster)
    ]

rosterDecoder : Decoder (List Product)
rosterDecoder = Decode.list productDecoder

rosterResponseDecoder : Decoder (List Product)
rosterResponseDecoder =
  rosterDecoder 
   |> Decode.field "roster"
   |> Decode.field "roster"
   |> Decode.field "data"

userDecoder : Decoder User
userDecoder =
  Decode.succeed User
    |> required "email" Decode.string
    |> required "score" Decode.int
    |> required "roster" rosterDecoder

resultsDecoder : Decoder (List User)
resultsDecoder =
  Decode.list userDecoder
    |> Decode.field "allRosters"
    |> Decode.field "data"
