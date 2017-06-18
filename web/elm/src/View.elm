module View exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (hidden)
import Messages exposing (..)
import Invitation.View as InvitationView
import Invitation.ViewForm as InvitationForm
import Routing exposing (Route(..))
import Common.View exposing (warningMessage, backToHomeLink, popup)
import Search.View as SearchView
import Html.CssHelpers
import Css.WPCss as WPCss


{ id, class, classList } =
    Html.CssHelpers.withNamespace "weddingplanner"


indexView : Model -> Html Msg
indexView model =
    div [ id WPCss.Page ]
        [ header [ hidden (model.route == HomeRoute) ] [ backToHomeLink ]
        , section
            []
            [ page model ]
        , popup model.popup
        ]


page : Model -> Html Msg
page model =
    case model.route of
        HomeRoute ->
            SearchView.view model

        InvitationRoute id ->
            InvitationForm.viewInvitationForm model

        InvitationIndexRoute ->
            InvitationView.view model

        NotFoundRoute ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    warningMessage
        "fa fa-meh-o fa-stack-2x"
        "Page not found"
        backToHomeLink
