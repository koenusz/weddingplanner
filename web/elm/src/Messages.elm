module Messages exposing (..)

import Http
import Model exposing (..)
import Navigation
import Routing exposing (Route(..))
import Invitation.Messages


type Msg
    = FetchResult (Result Http.Error InvitationList)
    | FetchInvitation (Result Http.Error Invitation)
    | UpdateInvitation (Result Http.Error Invitation)
    | Paginate Int
    | UrlChange Navigation.Location
    | NavigateTo Route
    | HandleSearchInput String
    | HandleFormSubmit
    | HandleInvitationFormSubmit Invitation
    | InvitationMsg Invitation.Messages.Msg
    | ResetPopup
