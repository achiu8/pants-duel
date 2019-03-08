module Commands exposing (..)

import Http

import Json exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Queries exposing (..)

endpoint = "https://f5zps1a0u7.execute-api.us-east-1.amazonaws.com/dev/graphql"

fetchRoster : String -> Cmd Msg
fetchRoster email =
  Http.post
    { url = endpoint
    , body = Http.jsonBody (rosterQuery email)
    , expect = Http.expectJson ReceivedRoster rosterResponseDecoder
    }

fetchProducts : Cmd Msg
fetchProducts =
  Http.post
    { url = endpoint
    , body = Http.jsonBody productsQuery
    , expect = Http.expectJson ReceivedProducts productsDecoder
    }

fetchResults : Cmd Msg
fetchResults =
  Http.post
    { url = endpoint
    , body = Http.jsonBody resultsQuery
    , expect = Http.expectJson ReceivedResults resultsDecoder
    }

fetchPrevious : Cmd Msg
fetchPrevious =
  Http.post
    { url = endpoint
    , body = Http.jsonBody previousQuery
    , expect = Http.expectJson ReceivedPrevious resultsDecoder
    }

submitRoster : Model -> Cmd Msg
submitRoster model =
  Http.post
    { url = endpoint
    , body = Http.jsonBody (createRosterQuery model)
    , expect = Http.expectJson ReceivedResults resultsDecoder
    }
