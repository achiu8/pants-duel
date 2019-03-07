module Commands exposing (..)

import Http

import Models exposing (..)
import Msgs exposing (..)
import Utils exposing (..)

fetchProducts : Cmd Msg
fetchProducts =
  Http.get
    { url = "http://localhost:9000/products"
    , expect = Http.expectJson ReceivedProducts productsDecoder
    }

fetchLeaderboard : Cmd Msg
fetchLeaderboard =
  Http.get
    { url = "http://localhost:9000/leaderboard"
    , expect = Http.expectJson ReceivedLeaderboard leaderboardDecoder
    }

submitRoster : List Product -> Cmd Msg
submitRoster roster = Cmd.none
