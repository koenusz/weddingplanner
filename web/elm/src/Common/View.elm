module Common.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Routing exposing (Route(..))


backToHomeLink : Html Msg
backToHomeLink =
    a
        [ onClick <| NavigateTo HomeRoute ]
        [ text "← Back to main page" ]


warningMessage : String -> String -> Html Msg -> Html Msg
warningMessage iconClasses message content =
    div
        [ class "warning" ]
        [ span
            [ class "fa-stack" ]
            [ i [ class iconClasses ] [] ]
        , h4
            []
            [ text message ]
        , content
        ]


popup : Maybe String -> Html Msg
popup message =
    case message of
        Just message ->
            div
                [ style
                    [ ( "position", "absolute" )
                    , ( "right", "50px" )
                    , ( "width", "180px" )
                    , ( "height", "100px" )
                    , ( "border", "solid 2px black" )
                    , ( "background-color", "white" )
                    ]
                ]
                [ h1
                    [ style
                        [ ( "color", "green" )
                        , ( "text-align", "center" )
                        ]
                    ]
                    [ text message ]
                ]

        Nothing ->
            text ""


paginationList : Int -> Int -> Html Msg
paginationList totalPages pageNumber =
    List.range 1 totalPages
        |> List.map (paginationLink pageNumber)
        |> ul [ class "pagination" ]


paginationLink : Int -> Int -> Html Msg
paginationLink currentPage page =
    let
        classes =
            classList [ ( "active", currentPage == page ) ]
    in
        li
            []
            [ a
                [ classes
                , onClick <| Paginate page
                ]
                []
            ]
