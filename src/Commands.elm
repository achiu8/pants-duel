module Commands exposing (..)

import Http

import Json exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Queries exposing (..)

endpoint = "https://f5zps1a0u7.execute-api.us-east-1.amazonaws.com/dev/graphql"

fetchInitial : Cmd Msg
fetchInitial =
  Http.post
    { url = endpoint
    , body = Http.jsonBody initialQuery
    , expect = Http.expectJson ReceivedInitial initialDecoder
    }

fetchRoster : String -> Cmd Msg
fetchRoster email =
  Http.post
    { url = endpoint
    , body = Http.jsonBody (rosterQuery email)
    , expect = Http.expectJson ReceivedRoster rosterDecoder
    }

submitRoster : Model -> Cmd Msg
submitRoster model =
  Http.post
    { url = endpoint
    , body = Http.jsonBody (createRosterQuery model)
    , expect = Http.expectJson ReceivedResults resultsDecoder
    }

fetchResults : Cmd Msg
fetchResults =
  Http.post
    { url = endpoint
    , body = Http.jsonBody resultsQuery
    , expect = Http.expectJson ReceivedResults resultsDecoder
    }
