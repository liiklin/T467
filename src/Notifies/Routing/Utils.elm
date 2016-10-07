module Notifies.Routing.Utils exposing (..)

import Hop exposing (..)
import Hop.Types exposing (Config)
import Models
import Notifies.Models exposing (..)
import Routing.Config
import Notifies.Routing.Config exposing (..)


config : Config Models.Route
config =
    Routing.Config.config


toS : a -> String
toS =
    toString


reverseWithPrefix : Route -> String
reverseWithPrefix route =
    "/notifications" ++ (reverse route)


reverse : Route -> String
reverse route =
    case route of
        NotifiesRoute ->
            matcherToPath matcherNotifies []

        NotifyAddRoute ->
            matcherToPath matcherNotifyAdd []

        NotifyEditRoute id ->
            matcherToPath matcherNotifyEdit [ toS id ]

        NotFoundRoute ->
            ""
