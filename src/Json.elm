module Json exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Json.Encode as Encode exposing (..)

import Models exposing (..)
import Utils exposing (..)

productDecoder : Decoder Product
productDecoder =
  Decode.succeed Product
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
    [ ("name", Encode.string product.name)
    , ("category", Encode.string (String.toLower (categoryDisplay product.category)))
    , ("price", Encode.int product.price)
    ]

rosterEncoder : Model -> Encode.Value
rosterEncoder model =
  object
    [ ("email", Encode.string model.email)
    , ("roster", Encode.list productEncoder model.roster)
    ]

userDecoder : Decoder User
userDecoder =
  Decode.succeed User
    |> required "email" Decode.string
    |> required "score" Decode.int
    |> required "roster" (Decode.list productDecoder)

resultsDecoder : Decoder (List User)
resultsDecoder =
  Decode.list userDecoder
    |> Decode.field "allRosters"
    |> Decode.field "data"

