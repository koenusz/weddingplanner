module Invitation.ViewForm exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Model exposing (..)
import Messages exposing (..)
import Invitation.Messages as IM
import Common.View exposing (warningMessage)


viewInvitationForm : Model -> Html Msg
viewInvitationForm model =
    case model.invitation of
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

        Success invitation ->
            div [ class "content" ]
                [ view invitation ]


view : Invitation -> Html Msg
view invitation =
    table
        [ style
            [ ( "width", "50%" )
            , ( "border", "2px solid black" )
            , ( "background-color", "aqua" )
            , ( "padding", "2px" )
            ]
        ]
        [ caption
            []
            [ text ("Welcome " ++ invitation.name ++ " please let us know if you will be attending.") ]
        , thead [] [ th [] [ text "" ], th [] [ text "Attending?" ], th [] [ text "Number of Persons" ] ]
        , tbody []
            [ if invitation.wedding /= NotInvited then
                tr []
                    [ td [] [ text "Wedding" ]
                    , div [ onClick <| InvitationMsg (IM.Wedding (toggleStatus invitation.wedding)) ] [ invitationIcon invitation.party ]
                    , td []
                        [ input
                            [ type_ "search"
                            , style [ ( "margin-left", "5px" ) ]
                            , value <| toString invitation.attending_wedding
                            , onInput <| updateInvitation Wedding
                            ]
                            []
                        ]
                    ]
              else
                text ""
            , if invitation.party /= NotInvited then
                tr []
                    [ td [] [ text "Party" ]
                    , div [ onClick <| InvitationMsg (IM.Party (toggleStatus invitation.party)) ] [ invitationIcon invitation.party ]
                    , td []
                        [ input
                            [ type_ "search"
                            , style [ ( "margin-left", "5px" ) ]
                            , value <| toString invitation.attending_party
                            , onInput <| updateInvitation Party
                            ]
                            []
                        ]
                    ]
              else
                text ""
            , if invitation.dinner /= NotInvited then
                tr []
                    [ td [] [ text "Dinner" ]
                    , div [ onClick <| InvitationMsg (IM.Dinner (toggleStatus invitation.dinner)) ] [ invitationIcon invitation.dinner ]
                    , td []
                        [ input
                            [ type_ "search"
                            , style [ ( "margin-left", "5px" ) ]
                            , value <| toString invitation.attending_dinner
                            , onInput <| updateInvitation Dinner
                            ]
                            []
                        ]
                    ]
              else
                text ""
            ]
        , tfoot [] [ button [ onClick <| HandleInvitationFormSubmit invitation ] [ text "Save" ] ]
        ]


stringToInt : String -> Int
stringToInt string =
    case String.toInt string of
        Ok intValue ->
            intValue

        Err error ->
            0


updateInvitation : Event -> String -> Msg
updateInvitation event value =
    let
        intValue =
            stringToInt value
    in
        case event of
            Wedding ->
                InvitationMsg (IM.AttendingWedding intValue)

            Party ->
                InvitationMsg (IM.AttendingParty intValue)

            Dinner ->
                InvitationMsg (IM.AttendingDinner intValue)


invitationIcon : Status -> Html Msg
invitationIcon status =
    case status of
        NotInvited ->
            td
                [ class "fa fa-question-circle-o fa-lg"
                , style [ ( "color", "yellow" ) ]
                ]
                []

        Invited ->
            td
                [ class "fa fa-question-circle-o fa-lg"
                , style [ ( "color", "yellow" ) ]
                ]
                []

        Accepted ->
            td
                [ class "fa fa-check fa-lg"
                , style [ ( "color", "green" ) ]
                ]
                []

        Declined ->
            td
                [ class "fa fa-close fa-lg"
                , style [ ( "color", "red" ) ]
                ]
                []
