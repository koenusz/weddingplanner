module Invitation.Update exposing (..)

import Model exposing (Model, RemoteData(..))
import Invitation.Messages exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case model.invitation of
        Success inv ->
            case msg of
                Name name ->
                    ({ model | invitation = Success { inv | name = name } }) ! []

                Wedding wedding ->
                    ({ model | invitation = Success { inv | wedding = wedding } }) ! []

                Party party ->
                    ({ model | invitation = Success { inv | party = party } }) ! []

                Dinner dinner ->
                    ({ model | invitation = Success { inv | dinner = dinner } }) ! []

                AttendingWedding number ->
                    ({ model | invitation = Success { inv | attending_wedding = number } }) ! []

                AttendingParty number ->
                    ({ model | invitation = Success { inv | attending_party = number } }) ! []

                AttendingDinner number ->
                    ({ model | invitation = Success { inv | attending_dinner = number } }) ! []

        _ ->
            model ! []
