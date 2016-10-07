module Notifies.Models exposing (..)


type alias NotifyId =
    Int


type alias Title =
    String


type alias Message =
    String


type alias Pinned =
    Bool


type Field
    = Ltitle
    | Lmessage
    | Lpinned


type alias Notify =
    { id : NotifyId
    , title : Title
    , message : Message
    , created : String
    , pinned : Pinned
    , archived : Bool
    , duration : Int
    }



-- ROUTING


type Route
    = NotifiesRoute
    | NotifyAddRoute
    | NotifyEditRoute NotifyId
    | NotFoundRoute


notifies : List Notify
notifies =
    [-- { title = "欢迎使用 elm 前端框架`1`"
     --   , pinned = False
     --   , message = "23333, 66666,1"
     --   , id = 1
     --   , duration = 999984
     --   , created = "2016-08-14T08:14:43+00:00"
     --   , archived = False
     --   }
     -- , { title = "欢迎使用 elm 前端框架`2`"
     --   , pinned = True
     --   , message = "23333, 66666,2"
     --   , id = 2
     --   , duration = 999984
     --   , created = "2016-08-14T08:14:43+00:00"
     --   , archived = False
     --   }
     -- , { title = "欢迎使用 elm 前端框架`3`"
     --   , pinned = True
     --   , message = "23333, 66666,3"
     --   , id = 3
     --   , duration = 999984
     --   , created = "2016-08-14T08:14:43+00:00"
     --   , archived = True
     --   }
    ]
