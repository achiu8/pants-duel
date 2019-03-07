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

fetchResults : Cmd Msg
fetchResults =
  Http.get
    { url = "http://localhost:9000/results"
    , expect = Http.expectJson ReceivedResults resultsDecoder
    }

submitRoster : List Product -> Cmd Msg
submitRoster roster = Cmd.none
