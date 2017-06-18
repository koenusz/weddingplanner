module Commands exposing (..)

import Http
import Messages exposing (Msg(..))
import Codec exposing (..)
import Model exposing (Invitation)


indexInvitations : Int -> String -> Cmd Msg
indexInvitations pageNumber search =
    let
        apiUrl =
            "/api/invitations?page=" ++ (toString pageNumber) ++ "&search=" ++ search

        request =
            Http.get apiUrl invitationListDecoder
    in
        Http.send FetchResult request


getInvitation : Int -> Cmd Msg
getInvitation id =
    let
        apiUrl =
            "/api/invitations/" ++ toString id

        request =
            Http.get apiUrl invitationDecoder
    in
        Http.send FetchInvitation request


updateInvitation : Invitation -> Cmd Msg
updateInvitation invitation =
    let
        apiUrl =
            "/api/invitations/" ++ toString invitation.id

        request =
            (put apiUrl <| Http.jsonBody (encodeInvitation invitation))
    in
        Http.send UpdateInvitation request


put : String -> Http.Body -> Http.Request Invitation
put url body =
    Http.request
        { method = "PUT"
        , headers = []
        , url = url
        , body = body
        , expect = Http.expectJson invitationDecoder
        , timeout = Nothing
        , withCredentials = False
        }
