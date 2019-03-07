module Utils exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

import Models exposing (..)

budgetLeft : List Product -> Int
budgetLeft = List.foldr (\p left -> left - p.price) 50

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
    Accessories -> "https://png.pngtree.com/svg/20170905/00d644ac9c.svg"
    Other       -> "https://png.pngtree.com/svg/20161213/a3817a439c.svg"

productDecoder : Decoder Product
productDecoder =
  Decode.succeed Product
   |> required "name" string
   |> required "category" (Decode.map categoryFromString string)
   |> required "price" int

productsDecoder : Decoder (List Product)
productsDecoder = Decode.field "products" (Decode.list productDecoder)
