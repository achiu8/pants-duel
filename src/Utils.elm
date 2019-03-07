module Utils exposing (..)

import FormatNumber exposing (format)
import FormatNumber.Locales exposing (usLocale)
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Json.Encode as Encode exposing (..)

import Models exposing (..)

budgetLeft : List Product -> Int
budgetLeft = List.foldr (\p left -> left - p.price) 5000

categoryDisplay : Category -> String
categoryDisplay category =
  case category of
    Bottoms     -> "Bottoms"
    Tops        -> "Tops"
    Outerwear   -> "Outerwear"
    Suits       -> "Suits"
    Accessories -> "Accessories"
    Other       -> "Other"

categoryFromString : String -> Category
categoryFromString s =
  case String.toLower s of
    "bottoms"     -> Bottoms
    "tops"        -> Tops
    "outerwear"   -> Outerwear
    "suits"       -> Suits
    "accessories" -> Accessories
    _             -> Other

categoryImage : Category -> String
categoryImage category =
  case category of
    Bottoms     -> "https://png.pngtree.com/svg/20170804/7007aea49e.svg"
    Tops        -> "https://png.pngtree.com/svg/20160621/db3c3c4d9c.svg"
    Outerwear   -> "https://png.pngtree.com/svg/20160606/2597271a8b.svg"
    Suits       -> "https://png.pngtree.com/svg/20170509/703d28498b.svg"
    Accessories -> "https://png.pngtree.com/svg/20170907/f869eff09c.svg"
    Other       -> "https://png.pngtree.com/svg/20161213/a3817a439c.svg"

productDecoder : Decoder Product
productDecoder =
  Decode.succeed Product
   |> required "name" Decode.string
   |> required "category" (Decode.map categoryFromString Decode.string)
   |> required "price" Decode.int

productsDecoder : Decoder (List Product)
productsDecoder = Decode.field "products" (Decode.list productDecoder)

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
resultsDecoder = Decode.field "results" (Decode.list userDecoder)

currency : Int -> String
currency = String.append "$" << format { usLocale | decimals = 0 } << toFloat

findInResults : Model -> List User
findInResults model = List.filter (\user -> user.email == model.email) model.results

alreadySubmitted : Model -> Bool
alreadySubmitted = not << (==) 0 << List.length << findInResults

rosterFromResults : Model -> List Product
rosterFromResults model =
  if List.isEmpty model.roster
    then case (findInResults model) of
      user :: _ -> user.roster
      _         -> []
    else model.roster

validRoster : List Product -> Bool
validRoster roster =
  categories
    |> List.all (\c -> List.any (\p -> p.category == c) roster)
