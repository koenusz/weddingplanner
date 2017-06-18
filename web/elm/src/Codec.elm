module Codec exposing (..)

import Json.Decode as JD exposing (string, int, bool, list)
import Json.Encode as JE
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)


invitationListDecoder : JD.Decoder InvitationList
invitationListDecoder =
    decode
        InvitationList
        |> required "entries" (list invitationDecoder)
        |> required "page_number" int
        |> required "total_entries" int
        |> required "total_pages" int


invitationDecoder : JD.Decoder Invitation
invitationDecoder =
    decode Invitation
        |> required "id" int
        |> required "name" string
        |> required "wedding" (JD.map stringToStatus string)
        |> required "party" (JD.map stringToStatus string)
        |> required "dinner" (JD.map stringToStatus string)
        |> required "attending_wedding" int
        |> required "attending_party" int
        |> required "attending_dinner" int


encodeInvitation : Invitation -> JE.Value
encodeInvitation invitation =
    JE.object
        [ ( "id", JE.int invitation.id )
        , ( "invitation"
          , JE.object
                [ ( "name", JE.string invitation.name )
                , ( "wedding", JE.string <| toString invitation.wedding )
                , ( "party", JE.string <| toString invitation.party )
                , ( "dinner", JE.string <| toString invitation.dinner )
                , ( "attending_wedding", JE.int invitation.attending_wedding )
                , ( "attending_party", JE.int invitation.attending_party )
                , ( "attending_dinner", JE.int invitation.attending_dinner )
                ]
          )
        ]
