module Models exposing (..)

type Page
  = Home
  | Roster


type Category
  = Bottoms
  | Tops
  | Outerwear
  | Suits
  | Accessories
  | Other

type alias Product =
  { name : String
  , category : Category
  , price : Int
  }

type alias Model =
  { page : Page
  , email : String
  , category : Category
  , roster : List Product
  , products : List Product
  }

categories : List Category
categories =
  [ Bottoms
  , Tops
  , Outerwear
  , Suits
  , Accessories
  ]

initialModel : Model
initialModel =
  { page = Home
  , email = ""
  , category = Bottoms
  , roster = []
  , products =
      [ Product "stretch chinos" Bottoms 15
      , Product "tech chinos" Bottoms 10
      , Product "stretch denim" Bottoms 10
      , Product "riviera" Tops 5
      , Product "oxford" Tops 5
      , Product "t-shirt" Tops 5
      , Product "parka" Outerwear 5
      , Product "tuxedo" Suits 10
      ]
  }
