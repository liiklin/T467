module Main exposing (..)

import View as App exposing (..)
import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Messages as App exposing (..)
import Models as App exposing (..)
import Navigation
import Update as App exposing (..)
import Routing.Config


urlParser : Navigation.Parser ( Route, Hop.Types.Location )
urlParser =
    Navigation.makeParser (.href >> matchUrl Routing.Config.config)


urlUpdate : ( Route, Hop.Types.Location ) -> AppModel -> ( AppModel, Cmd Msg )
urlUpdate ( route, location ) model =
    let
        _ =
            Debug.log "urlUpdate location" location
    in
        ( { model | route = route, location = location }, Cmd.none )


init : ( Route, Hop.Types.Location ) -> ( AppModel, Cmd Msg )
init ( route, location ) =
    ( newAppModel route location, Cmd.none )


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = (always Sub.none)
        }
