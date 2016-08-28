module Notifys.Routing.Utils exposing (..)

import Hop exposing (..)
import Hop.Types exposing (Config)
import Models
import Notifys.Models exposing (..)
import Routing.Config
import Notifys.Routing.Config exposing (..)


config : Config Models.Route
config =
    Routing.Config.config


toS : a -> String
toS =
    toString


reverseWithPrefix : Route -> String
reverseWithPrefix route =
    "/faq" ++ (reverse route)


reverse : Route -> String
reverse route =
    case route of
        NotifysRoute ->
            matcherToPath matcherNotifys []

        NotifyRoute id ->
            matcherToPath matcherNotify [ toS id ]

        NotifyEditRoute id ->
            matcherToPath matcherNotifyEdit [ toS id ]

        NotFoundRoute ->
            ""
