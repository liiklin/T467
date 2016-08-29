module Notifies.Update exposing (..)

import Debug
import Navigation
import Hop exposing (makeUrl, makeUrlFromLocation, addQuery, setQuery)
import Hop.Types exposing (Config, Location)
import Routing.Config
import Models
import Notifies.Models exposing (..)
import Notifies.Messages exposing (Msg(..))
import Notifies.Routing.Utils


type alias UpdateModel =
    { notifies : List Notify
    , location : Location
    }


routerConfig : Config Models.Route
routerConfig =
    Routing.Config.config


navigationCmd : String -> Cmd a
navigationCmd path =
    Navigation.modifyUrl (makeUrl Routing.Config.config path)


update : Msg -> UpdateModel -> ( UpdateModel, Cmd Msg )
update message model =
    case Debug.log "message" message of
        Show id ->
            let
                path =
                    Notifies.Routing.Utils.reverseWithPrefix (Notifies.Models.NotifyRoute id)
            in
                ( model, navigationCmd path )

        Edit id ->
            let
                path =
                    Notifies.Routing.Utils.reverseWithPrefix (Notifies.Models.NotifyEditRoute id)
            in
                ( model, navigationCmd path )

        Update id prop value ->
            let
                udpatedNotifies =
                    List.map (updateWithId id prop value) model.notifies
            in
                ( { model | notifies = udpatedNotifies }, Cmd.none )

        AddQuery query ->
            let
                command =
                    model.location
                        |> addQuery query
                        |> makeUrlFromLocation routerConfig
                        |> Navigation.modifyUrl
            in
                ( model, command )

        SetQuery query ->
            let
                command =
                    model.location
                        |> setQuery query
                        |> makeUrlFromLocation routerConfig
                        |> Navigation.modifyUrl
            in
                ( model, command )


updateWithId : NotifyId -> String -> String -> Notify -> Notify
updateWithId id prop value language =
    if id == language.id then
        case prop of
            "name" ->
                { language | name = value }

            _ ->
                language
    else
        language
