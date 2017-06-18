module Invitation.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)
import Messages exposing (..)
import Routing exposing (Route(..))
import Common.View exposing (warningMessage, paginationList)


view : Model -> Html Msg
view model =
    case model.invitations of
        NotRequested ->
            text ""

        Requesting ->
            warningMessage
                "fa fa-spin fa-cog fa-2x fa-fw"
                "Searching for contacts"
                (text "")

        Failure error ->
            warningMessage
                "fa fa-meh-o fa-stack-2x"
                error
                (text "")

        Success invitations ->
            div []
                [ div [ class "content" ]
                    [ paginationList invitations.total_pages
                        invitations.page_number
                    , div
                        []
                        [ viewList invitations.entries ]
                    ]
                , paginationList invitations.total_pages invitations.page_number
                ]


viewList : List Invitation -> Html Msg
viewList list =
    table []
        [ caption [] [ text "guests invited to the wedding" ]
        , thead [] [ th [] [ text "name" ], th [] [ text "wedding" ], th [] [ text "party" ], th [] [ text "dinner" ] ]
        , tbody [] (List.map (viewInvitation) list)
        ]


selectIcon : Status -> String
selectIcon status =
    case status of
        NotInvited ->
            "fa fa-stop fa-lg"

        Invited ->
            "fa fa-envelope-o fa-lg"

        Accepted ->
            "fa fa-check fa-lg"

        Declined ->
            "fa fa-close fa-lg"


viewInvitation : Invitation -> Html Msg
viewInvitation invitation =
    tr [ class "invitation", onClick <| NavigateTo (InvitationRoute invitation.id) ]
        [ td [] [ text invitation.name ]
        , td [ class (selectIcon invitation.wedding) ] []
        , td [ class (selectIcon invitation.party) ] []
        , td [ class (selectIcon invitation.dinner) ] []
        ]
