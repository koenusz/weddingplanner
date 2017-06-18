-- web/elm/Routing.elm


module Routing exposing (..)

import Navigation
import UrlParser exposing (..)


type Route
    = HomeRoute
    | NotFoundRoute
    | InvitationRoute Int
    | InvitationIndexRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute <| s ""
        , map InvitationRoute <| s "invitations" </> int
        , map InvitationIndexRoute <| s "invitations"
        ]


parse : Navigation.Location -> Route
parse location =
    case UrlParser.parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


toPath : Route -> String
toPath route =
    case route of
        HomeRoute ->
            "/"

        NotFoundRoute ->
            "/not-found"

        InvitationRoute id ->
            "/invitations/" ++ toString id

        InvitationIndexRoute ->
            "/invitations"
