module Commands exposing (..)

import Http

import Json exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Queries exposing (..)

endpoint = "https://f5zps1a0u7.execute-api.us-east-1.amazonaws.com/dev/graphql"

fetchProducts : Cmd Msg
fetchProducts =
  Http.post
    { url = endpoint
    , body = Http.jsonBody productsQuery
    , expect = Http.expectJson ReceivedProducts productsDecoder
    }

fetchResults : Cmd Msg
fetchResults =
  Http.get
    { url = "http://localhost:9000/results"
    , expect = Http.expectJson ReceivedResults resultsDecoder
    }

submitRoster : Model -> Cmd Msg
submitRoster model =
  Http.post
    { url = "http://localhost:9000/roster"
    , body = Http.jsonBody (rosterEncoder model)
    , expect = Http.expectJson ReceivedResults resultsDecoder
    }
