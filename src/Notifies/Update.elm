module Notifies.Update exposing (..)

import Notifies.Messages exposing (..)
import Notifies.Models exposing (Notify, NotifyId, Pinned)
import Notifies.Commands exposing (save)
import Navigation


changeTopCommands : NotifyId -> Bool -> List Notify -> List (Cmd Msg)
changeTopCommands notifyId pinned =
    let
        cmdForNotify existingNotify =
            if existingNotify.id == notifyId then
                save { existingNotify | pinned = pinned } "PUT"
            else
                Cmd.none
    in
        List.map cmdForNotify


updateNotify : Notify -> String -> List Notify -> List Notify
updateNotify updatedNotify opt =
    if opt == "save" then
        let
            select existingNotify =
                if existingNotify.id == updatedNotify.id then
                    updatedNotify
                else
                    existingNotify
        in
            List.map select
    else
        List.filter (\t -> t.id /= updatedNotify.id)


deleteNotify : NotifyId -> List Notify -> List (Cmd Msg)
deleteNotify notifyId =
    let
        cmdForNotify existingNotify =
            if existingNotify.id == notifyId then
                save { existingNotify | pinned = existingNotify.pinned } "DELETE"
            else
                Cmd.none
    in
        List.map cmdForNotify


saveNotify : NotifyId -> Notify -> String -> List Notify -> List (Cmd Msg)
saveNotify notifyId notify opt =
    let
        _ =
            Debug.log "notify" notify

        cmdForNotify existingNotify =
            if existingNotify.id == notifyId then
                save { existingNotify | pinned = notify.pinned } opt
            else
                Cmd.none
    in
        List.map cmdForNotify


update : Msg -> List Notify -> ( List Notify, Cmd Msg )
update message notifies =
    case Debug.log "update message" message of
        FetchAllDone newNotifies ->
            ( newNotifies, Cmd.none )

        FetchAllFail error ->
            ( notifies, Cmd.none )

        AddNotify ->
            ( notifies, Navigation.newUrl "#notifications/new" )

        ShowNotifies ->
            ( notifies, Navigation.newUrl "#notifications" )

        -- FormInput fieldId val ->
        --     let
        --         res =
        --             case fieldId of
        --                 Ltitle ->
        --                     { Notify.Models.notify | title = val }
        --
        --                 Lmessage ->
        --                     { Notify.Models.notify | message = val }
        --
        --                 Lpinned ->
        --                     { Notify.Models.notify | pinned = True }
        --     in
        --         (res | res) ! []

        EditNotify id ->
            ( notifies, Navigation.newUrl ("#notifications/" ++ (toString id)) )

        ChangeTop id pinned ->
            ( notifies, changeTopCommands id pinned notifies |> Cmd.batch )

        SaveNotify notify ->
            ( notifies, saveNotify notify.id notify "PUT" notifies |> Cmd.batch )

        DeleteNotify id ->
            ( notifies, deleteNotify id notifies |> Cmd.batch )

        SaveSuccess updatedNotify ->
            ( updateNotify updatedNotify "save" notifies, Cmd.none )

        DeleteSuccess updatedNotify ->
            ( updateNotify updatedNotify "delete" notifies, Cmd.none )

        SaveFail error ->
            ( notifies, Cmd.none )
