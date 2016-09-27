module Notifies.Models exposing (..)


type alias NotifyId =
    Int


type alias Title =
    String


type alias Message =
    String


type alias Pinned =
    Bool


type alias Notify =
    { id : NotifyId
    , title : Title
    , message : Message
    , created : String
    , pinned : Pinned
    }


notify : Notify
notify =
    { id = 0
    , title = ""
    , message = ""
    , created = ""
    , pinned = True
    }
