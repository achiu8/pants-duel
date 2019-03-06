module Models exposing (..)

import Types exposing (..)

type alias Product =
  { name : String
  , category : String
  , price : Int
  }

type alias Model =
  { page : Page
  , email : String
  , category : String
  , roster : List Product
  , products : List Product
  }

initialModel : Model
initialModel =
  { page = Home
  , email = ""
  , category = "bottoms"
  , roster = []
  , products =
      [ Product "stretch chinos" "bottoms" 15
      , Product "tech chinos" "bottoms" 10
      , Product "stretch denim" "bottoms" 10
      , Product "riviera" "tops" 5
      , Product "oxford" "tops" 5
      , Product "t-shirt" "tops" 5
      , Product "parka" "outerwear" 5
      ]
  }
