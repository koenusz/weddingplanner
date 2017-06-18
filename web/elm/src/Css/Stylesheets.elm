port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Css.WPCss as WPCss


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ("../static/css/app.css", Css.File.compile [ WPCss.css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure