module Model exposing (..)

import Routing exposing (Route(..))


type Event
    = Wedding
    | Party
    | Dinner


type RemoteData e a
    = NotRequested
    | Requesting
    | Failure e
    | Success a


type Status
    = NotInvited
    | Invited
    | Accepted
    | Declined


type alias Model =
    { invitations : RemoteData String InvitationList
    , invitation : RemoteData String Invitation
    , error : Maybe String
    , search : String
    , route : Route
    , popup : Maybe String
    }


type alias InvitationList =
    { entries : List Invitation
    , page_number : Int
    , total_entries : Int
    , total_pages : Int
    }


type alias Invitation =
    { id : Int
    , name : String
    , wedding : Status
    , party : Status
    , dinner : Status
    , attending_wedding : Int
    , attending_party : Int
    , attending_dinner : Int
    }


initialModel : Route -> Model
initialModel route =
    { invitations = NotRequested
    , invitation = NotRequested
    , error = Nothing
    , search = ""
    , route = route
    , popup = Nothing
    }


initiaInvitation : Invitation
initiaInvitation =
    { id = 0
    , name = ""
    , wedding = NotInvited
    , party = NotInvited
    , dinner = NotInvited
    , attending_wedding = 0
    , attending_party = 0
    , attending_dinner = 0
    }


toggleStatus : Status -> Status
toggleStatus old =
    case old of
        NotInvited ->
            NotInvited

        Invited ->
            Accepted

        Accepted ->
            Declined

        Declined ->
            Accepted


stringToStatus : String -> Status
stringToStatus string =
    case string of
        "NotInvited" ->
            NotInvited

        "Invited" ->
            Invited

        "Accepted" ->
            Accepted

        "Declined" ->
            Declined

        _ ->
            NotInvited
