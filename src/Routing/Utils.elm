module Routing.Utils exposing (..)

import Hop exposing (..)
import Models exposing (..)
import Routing.Config exposing (..)
import Faqs.Routing.Utils
import Notifies.Routing.Utils


reverse : Route -> String
reverse route =
    case route of
        NotifiesRoutes subRoute ->
            let
                parentPath =
                    matcherToPath matchersNotifies []

                subPath =
                    Notifies.Routing.Utils.reverse subRoute
            in
                parentPath ++ subPath

        FaqsRoutes subRoute ->
            let
                parentPath =
                    matcherToPath matchersFaqs []

                subPath =
                    Faqs.Routing.Utils.reverse subRoute
            in
                parentPath ++ subPath

        NotFoundRoute ->
            ""
