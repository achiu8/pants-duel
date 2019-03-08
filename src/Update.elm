module Update exposing (..)

import Commands exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Utils exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    View page ->
      ({ model | page = page }, Cmd.none)

    Login ->
      update CheckSubmitted { model | loggedIn = True }

    UpdateEmail email ->
      ({ model | email = email }, Cmd.none)

    SelectCategory category ->
      ({ model | category = category }, Cmd.none)

    SelectProduct product ->
      ({ model | roster = product :: model.roster }, Cmd.none)

    RemoveProduct product ->
      ({ model | roster = List.filter ((/=) product) model.roster }, Cmd.none)

    ReceivedProducts result ->
      case result of
        Ok products ->
          ({ model | products = products }, fetchResults)
        Err _ ->
          (model, Cmd.none)

    FetchResults ->
      (model, fetchResults)

    ReceivedResults result ->
      case result of
        Ok results ->
          update CheckSubmitted { model | results = results }
        Err _ ->
          (model, Cmd.none)

    SubmitRoster ->
      (model, submitRoster model)

    CheckSubmitted ->
      ( { model | submitted = alreadySubmitted model, roster = rosterFromResults model }
      , Cmd.none
      )

    NoOp ->
      (model, Cmd.none)
