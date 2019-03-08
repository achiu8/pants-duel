module Utils exposing (..)

import Dict exposing (..)
import FormatNumber exposing (format)
import FormatNumber.Locales exposing (usLocale)

import Models exposing (..)

budgetLeft : List Product -> Int
budgetLeft = List.foldr (\p left -> left - p.price) 10000

categoryDisplay : Category -> String
categoryDisplay category =
  case category of
    Bottoms     -> "Bottoms"
    Tops        -> "Tops"
    Outerwear   -> "Outerwear"
    Suiting     -> "Suiting"
    Accessories -> "Accessories"
    Other       -> "Other"

categoryFromString : String -> Category
categoryFromString s =
  case String.toLower s of
    "bottoms"     -> Bottoms
    "tops"        -> Tops
    "outerwear"   -> Outerwear
    "suiting"     -> Suiting
    "accessories" -> Accessories
    _             -> Other

categoryImage : Category -> String
categoryImage category =
  case category of
    Bottoms     -> "https://png.pngtree.com/svg/20170804/7007aea49e.svg"
    Tops        -> "https://png.pngtree.com/svg/20160621/db3c3c4d9c.svg"
    Outerwear   -> "https://png.pngtree.com/svg/20160606/2597271a8b.svg"
    Suiting     -> "https://png.pngtree.com/svg/20170509/703d28498b.svg"
    Accessories -> "https://png.pngtree.com/svg/20170907/f869eff09c.svg"
    Other       -> "https://png.pngtree.com/svg/20161213/a3817a439c.svg"

currency : Int -> String
currency = String.append "$" << format { usLocale | decimals = 0 } << toFloat

findInResults : Model -> List User
findInResults model = List.filter (\user -> user.email == model.email) model.results

alreadySubmitted : Model -> Bool
alreadySubmitted = not << (==) 0 << List.length << findInResults

validRoster : List Product -> Bool
validRoster roster =
  categories
    |> List.all (\c -> List.any (\p -> p.category == c) roster)

countCategories : List Product -> Dict String Int
countCategories roster =
  let update = Maybe.map ((+) 1) << Just << Maybe.withDefault 0
  in List.foldr
       (\p counts -> Dict.update (categoryDisplay p.category) update counts)
       Dict.empty
       roster
