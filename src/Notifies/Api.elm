module Notifies.Api exposing (..)

import Json.Decode as JsonD exposing ((:=))
-- import Json.Encode as JsonE
import Http
import Task
import Notifies.Models exposing (..)


baseUrl : String
baseUrl =
    "http://127.0.0.1/api/v1"


getNotifies : (Http.Error -> msg) -> (List Notify -> msg) -> Cmd msg
getNotifies errorMsg msg =
    Http.get notifiesDecoder (baseUrl ++ "/notifications")
        |> Task.perform errorMsg msg


notifiesDecoder : JsonD.Decoder (List Notify)
notifiesDecoder =
    JsonD.list notifyDecoder


notifyDecoder : JsonD.Decoder Notify
notifyDecoder =
    JsonD.object7 Notify
        ("id" := JsonD.int)
        ("title" := JsonD.string)
        ("message" := JsonD.string)
        ("created" := JsonD.string)
        ("pinned" := JsonD.bool)
        ("archived" := JsonD.bool)
        ("duration" := JsonD.int)
