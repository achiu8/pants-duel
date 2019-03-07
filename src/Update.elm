module Update exposing (..)

import Commands exposing (..)
import Models exposing (..)
import Msgs exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    View page ->
      ({ model | page = page }, Cmd.none)

    Login ->
      ({ model | loggedIn = True }, Cmd.none)

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
          ({ model | products = products }, fetchLeaderboard)
        Err _ ->
          (model, Cmd.none)

    ReceivedLeaderboard result ->
      case result of
        Ok leaderboard ->
          ({ model | leaderboard = leaderboard }, Cmd.none)
        Err _ ->
          (model, Cmd.none)

    SubmitRoster ->
      (model, submitRoster model.roster)

    NoOp ->
      (model, Cmd.none)
