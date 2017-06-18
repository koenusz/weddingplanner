module Main exposing (..)

import Messages exposing (Msg(..))
import Model exposing (..)
import Update exposing (..)
import View exposing (indexView)
import Navigation
import Routing exposing (parse)


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parse location

        model =
            initialModel currentRoute
    in
        urlUpdate model


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = indexView
        , update = update
        , subscriptions = always <| Sub.none
        }
