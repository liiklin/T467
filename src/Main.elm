module Main exposing (..)

import Navigation
import Hop
import Hop.Types exposing (Address)
import Messages exposing (..)
import Models exposing (..)
import Update exposing (..)
import View exposing (..)
import Routing
import UrlParser


urlParser : Navigation.Parser ( Route, Address )
urlParser =
    let
        parse path =
            path
                |> UrlParser.parse identity Routing.routes
                |> Result.withDefault NotFoundRoute

        matcher =
            Hop.makeResolver Routing.config parse
    in
        Navigation.makeParser (.href >> matcher)


urlUpdate : ( Route, Address ) -> AppModel -> ( AppModel, Cmd Msg )
urlUpdate ( route, address ) model =
    let
        _ =
            Debug.log "urlUpdate address" address
    in
        ( { model | route = route, address = address }, Cmd.none )


init : ( Route, Address ) -> ( AppModel, Cmd Msg )
init ( route, address ) =
    ( newAppModel route address, Cmd.none )


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = (always Sub.none)
        }
