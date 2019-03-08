module Models exposing (..)

type Page
  = Home
  | BuildRoster
  | ViewRoster
  | Results

type Category
  = Bottoms
  | Tops
  | Outerwear
  | Suiting
  | Accessories
  | Other

type Game
  = Current
  | Previous

type alias Product =
  { id : String
  , name : String
  , category : Category
  , price : Int
  }

type alias Model =
  { page : Page
  , email : String
  , loggedIn : Bool
  , submitted : Bool
  , category : Category
  , roster : List Product
  , products : List Product
  , results : List User
  }

type alias User =
  { email : String
  , score : Int
  }

categories : List Category
categories =
  [ Bottoms
  , Tops
  , Outerwear
  , Suiting
  , Accessories
  ]

initialModel : Model
initialModel =
  { page = Home
  , email = ""
  , loggedIn = False
  , submitted = False
  , category = Bottoms
  , roster = []
  , products = []
  , results = []
  }
