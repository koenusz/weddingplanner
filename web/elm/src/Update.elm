-- web/elm/Update.elm


module Update exposing (..)

import Messages exposing (..)
import Model exposing (..)
import Commands exposing (..)
import Routing exposing (parse, Route(..), toPath)
import Navigation
import Invitation.Update
import Delay


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchResult (Ok response) ->
            { model | invitations = Success response } ! []

        FetchResult (Err error) ->
            { model | invitations = Failure "Something went wrong..." } ! []

        Paginate pageNumber ->
            model ! [ indexInvitations pageNumber "" ]

        UrlChange location ->
            let
                currentRoute =
                    parse location
            in
                urlUpdate { model | route = currentRoute }

        NavigateTo route ->
            model ! [ Navigation.newUrl <| toPath route ]

        FetchInvitation (Ok response) ->
            { model | invitation = Success response } ! []

        FetchInvitation (Err response) ->
            { model | invitation = Failure "Something went wrong..." } ! []

        UpdateInvitation (Ok response) ->
            { model | invitation = Success response, popup = Just "Saved sucesfully" } ! []

        UpdateInvitation (Err response) ->
            { model | invitation = Failure "Something went wrong...", popup = Just "Something went wrong..." } ! []

        HandleSearchInput value ->
            { model | search = value } ! []

        HandleFormSubmit ->
            model ! [ indexInvitations 1 model.search ]

        HandleInvitationFormSubmit invitation ->
            { model | popup = Just "Saved sucesfully" }
                ! [ updateInvitation invitation
                  , Delay.after 5000 ResetPopup
                  ]

        ResetPopup ->
            { model | popup = Nothing } ! []

        InvitationMsg msg ->
            let
                ( invitationModel, invitationCmd ) =
                    Invitation.Update.update msg model
            in
                ( invitationModel, Cmd.map InvitationMsg invitationCmd )


urlUpdate : Model -> ( Model, Cmd Msg )
urlUpdate model =
    case model.route of
        HomeRoute ->
            model ! [ Cmd.none ]

        InvitationRoute id ->
            { model | invitation = Requesting } ! [ getInvitation id ]

        InvitationIndexRoute ->
            { model | invitations = Requesting } ! [ indexInvitations 1 "" ]

        NotFoundRoute ->
            model ! []



-- HandleFormSubmit ->
--     { model | contactList = Requesting } ! [ fetch 1 model.search ]
