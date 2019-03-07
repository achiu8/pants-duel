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
      ({ model | loggedIn = True }, Cmd.none)

    UpdateEmail email ->
      update CheckSubmitted { model | email = email }

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

    ReceivedResults result ->
      case result of
        Ok results ->
          update CheckSubmitted { model | results = results }
        Err _ ->
          ({ model | email = "there was an erro" }, Cmd.none)

    SubmitRoster ->
      (model, submitRoster model)

    CheckSubmitted ->
      ({ model | submitted = alreadySubmitted model }, Cmd.none)

    NoOp ->
      (model, Cmd.none)
