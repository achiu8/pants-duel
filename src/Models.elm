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
  , loggedIn : Bool
  , category : Category
  , roster : List Product
  , products : List Product
  , results : List User
  }

type alias User =
  { email : String
  , roster : List Product
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
  , loggedIn = False
  , category = Bottoms
  , roster = []
  , products = []
  , results = []
  }
