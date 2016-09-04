module Api exposing (..)

import Json.Decode as JsonD exposing ((:=))
import Json.Encode as JsonE
import Http
import Task

import Faqs.Models exposing (Faq, faqs)
import Notifies.Models exposing (Notify, notifies)

type alias Artist =
    { id : Int
    , name : String
    }


baseUrl : String
baseUrl =
    "http://www.zhiyisoft.com:30240"


getArtists : (Http.Error -> msg) -> (List Artist -> msg) -> Cmd msg
getArtists errorMsg msg =
    Http.get artistsDecoder (baseUrl ++ "/notifications")
        |> Task.perform errorMsg msg

artistsDecoder : JsonD.Decoder (List Artist)
artistsDecoder =
    JsonD.list artistDecoder


artistDecoder : JsonD.Decoder Artist
artistDecoder =
    JsonD.object2 Artist
        ("artistId" := JsonD.int)
        ("artistName" := JsonD.string)
