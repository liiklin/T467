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
import Notifies.Api exposing (getNotifies)


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


mountNotifiesCmd : Cmd Msg
mountNotifiesCmd =
    getNotifies FetchNotifiesFailed HandleNotifiesRetrieved


update : Msg -> UpdateModel -> ( UpdateModel, Cmd Msg )
update message model =
    case Debug.log "notifise message" message of
        Add ->
            ( model
            , navigationCmd (Notifies.Routing.Utils.reverseWithPrefix NotifyAddRoute)
            )

        Cancel ->
            ( model
            , navigationCmd (Notifies.Routing.Utils.reverseWithPrefix NotifiesRoute)
            )

        Edit id ->
            let
                path =
                    Notifies.Routing.Utils.reverseWithPrefix (Notifies.Models.NotifyEditRoute id)
            in
                ( model, navigationCmd path )

        Delete id ->
            let
                updatedNotifies =
                    List.filter (\t -> t.id /= id) model.notifies
            in
                ( { model | notifies = updatedNotifies }
                , navigationCmd (Notifies.Routing.Utils.reverseWithPrefix NotifiesRoute)
                )

        SetTop id ->
            let
                updatedNotifies =
                    List.map (updatePinnedWithId id "pinned" True) model.notifies
            in
                ( { model | notifies = updatedNotifies }, Cmd.none )

        CancelTop id ->
            let
                updatedNotifies =
                    List.map (updatePinnedWithId id "pinned" False) model.notifies
            in
                ( { model | notifies = updatedNotifies }
                , Cmd.none
                )

        Update id prop value ->
            let
                updatedNotifies =
                    List.map (updateWithId id prop value) model.notifies
            in
                ( { model | notifies = updatedNotifies }, Cmd.none )

        ShowNotifies ->
            ( model, mountNotifiesCmd )

        FetchNotifiesFailed err ->
            ( model, Cmd.none )

        HandleNotifiesRetrieved notifies' ->
            ( { model | notifies = notifies' }
            , Cmd.none
            )


updateWithId : NotifyId -> String -> String -> Notify -> Notify
updateWithId id prop value notify =
    if id == notify.id then
        case prop of
            "title" ->
                { notify | title = value }

            _ ->
                notify
    else
        notify


updatePinnedWithId : NotifyId -> String -> Bool -> Notify -> Notify
updatePinnedWithId id prop value notify =
    if id == notify.id then
        case prop of
            "pinned" ->
                { notify | pinned = value }

            _ ->
                notify
    else
        notify
