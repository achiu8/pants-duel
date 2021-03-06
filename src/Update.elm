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
      ({ model | loggedIn = True }, fetchRoster model.email)

    UpdateEmail email ->
      ({ model | email = email }, Cmd.none)

    SelectCategory category ->
      ({ model | category = category }, Cmd.none)

    SelectProduct product ->
      ({ model | roster = product :: model.roster }, Cmd.none)

    RemoveProduct product ->
      ({ model | roster = List.filter ((/=) product) model.roster }, Cmd.none)

    ReceivedInitial result ->
      case result of
        Ok initial ->
          update CheckSubmitted
            { model
            | products = initial.products
            , previous = initial.previous
            }
        Err _ ->
          (model, Cmd.none)

    ReceivedRoster result ->
      case result of
        Ok roster ->
          update CheckSubmitted { model | roster = roster }
        Err _ ->
          (model, Cmd.none)

    SubmitRoster ->
      (model, submitRoster model)

    FetchResults ->
      (model, fetchResults)

    ReceivedResults result ->
      case result of
        Ok results ->
          update CheckSubmitted { model | results = results }
        Err _ ->
          (model, Cmd.none)

    CheckSubmitted ->
      ({ model | submitted = alreadySubmitted model } , Cmd.none)

    NoOp ->
      (model, Cmd.none)
