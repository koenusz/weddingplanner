--invitation.Messages


module Invitation.Messages exposing (..)

import Model exposing (Status)


type Msg
    = Name String
    | Wedding Status
    | Party Status
    | Dinner Status
    | AttendingWedding Int
    | AttendingParty Int
    | AttendingDinner Int
