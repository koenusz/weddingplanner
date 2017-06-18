module Search.View exposing (..)

import Messages exposing (Msg(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onSubmit, onClick)
import Model exposing (..)
import Common.View exposing (warningMessage, paginationList)
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div [ class "search" ]
        [ div
            [ class "form-wrapper" ]
            [ Html.form
                [ onSubmit HandleFormSubmit ]
                [ label []
                    [ text "Name"
                    , input
                        [ type_ "search"
                        , placeholder "What is your name?..."
                        , style [ ( "margin-left", "5px" ) ]
                        , value model.search
                        , onInput HandleSearchInput
                        ]
                        []
                    ]
                , button [] [ text "Search" ]
                ]
            ]
        , (listInvitations model)
        ]


listInvitations : Model -> Html Msg
listInvitations model =
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
                        (List.map
                            invitation
                            invitations.entries
                        )
                    ]
                , paginationList invitations.total_pages invitations.page_number
                ]


invitation : Invitation -> Html Msg
invitation invitation =
    div [ class "invitation" ]
        [ button [ onClick <| NavigateTo (InvitationRoute invitation.id) ] [ text <| "Are you? " ++ invitation.name ]
        ]
