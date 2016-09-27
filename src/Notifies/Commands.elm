module Notifies.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Task
import Notifies.Models exposing (NotifyId, Notify)
import Notifies.Messages exposing (..)


baseUrl : String
baseUrl =
    "http://www.zhiyisoft.com:30240"


fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    baseUrl ++ "/notifications"


saveUrl : NotifyId -> String
saveUrl notifyId =
    baseUrl ++ "/notifications/" ++ (toString notifyId)


saveTask : Notify -> String -> Task.Task Http.Error Notify
saveTask notify verb =
    let
        body =
            memberEncoded notify
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = verb
            , headers = [ ( "Content-Type", "application/json;charset=utf-8" ) ]
            , url = baseUrl ++ "/notifications/" ++ toString notify.id
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson memberDecoder


save : Notify -> String -> Cmd Msg
save notify verb =
    if verb /= "DELETE" then
        saveTask notify verb
            |> Task.perform SaveFail SaveSuccess
    else
        saveTask notify verb
            |> Task.perform SaveFail DeleteSuccess



-- DECODERS


collectionDecoder : Decode.Decoder (List Notify)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Notify
memberDecoder =
    Decode.object5 Notify
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("message" := Decode.string)
        ("created" := Decode.string)
        ("pinned" := Decode.bool)


memberEncoded : Notify -> Encode.Value
memberEncoded notify =
    let
        list =
            [ ( "title", Encode.string notify.title )
            , ( "message", Encode.string notify.message )
            , ( "pinned", Encode.bool notify.pinned )
            ]
    in
        list
            |> Encode.object
