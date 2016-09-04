module Notifies.Api exposing (..)

import Json.Decode as JsonD exposing ((:=))
import Json.Encode as JsonE
import Http
import Task
import Notifies.Models exposing (..)


baseUrl : String
baseUrl =
    "http://www.zhiyisoft.com:30240"


getArtists : (Http.Error -> msg) -> (List Notify -> msg) -> Cmd msg
getArtists errorMsg msg =
    Http.get artistsDecoder (baseUrl ++ "/notifications")
        |> Task.perform errorMsg msg


artistsDecoder : JsonD.Decoder (List Notify)
artistsDecoder =
    JsonD.list artistDecoder


artistDecoder : JsonD.Decoder Notify
artistDecoder =
    JsonD.object7 Notify
        ("id" := JsonD.int)
        ("title" := JsonD.string)
        ("message" := JsonD.string)
        ("created" := JsonD.string)
        ("pinned" := JsonD.bool)
        ("archived" := JsonD.bool)
        ("duration" := JsonD.int)
