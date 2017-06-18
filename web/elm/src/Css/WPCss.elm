module Css.WPCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, li)
import Css.Namespace exposing (namespace)


type CssClasses
    = NavBar
    | Pagination
    | Warning


type CssIds
    = Page


css : Stylesheet
css =
    (stylesheet << namespace "weddingplanner")
        [ body
            [ overflowX auto
            , width (pct 99)
            , height (vh 98)
            , fontFamilies [ (qt "Josefin Slab"), .value serif ]
            , border3 (px 150) solid transparent
            , property "border-image" "url(../images/invitation_front.png) 150 150 150 150 repeat"
            , minHeight (pct 100)
            , boxSizing borderBox
            ]
        , id Page
            [ backgroundColor (hex "59b300")
            , color (hex "CCFFFF")
            , width (pct 100)
            , height (pct 100)
            , padding (px 8)
            , margin zero
            ]
        , class NavBar
            [ margin zero
            , padding zero
            , children
                [ li
                    [ (display inlineBlock) |> important
                    , color primaryAccentColor
                    ]
                ]
            ]
        , class Pagination
            []
        ]


primaryAccentColor : Color
primaryAccentColor =
    hex "ccffaa"
