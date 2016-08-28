module Routing.Utils exposing (..)

import Hop exposing (..)
import Models exposing (..)
import Routing.Config exposing (..)
import Languages.Routing.Utils
import Faqs.Routing.Utils
import Notifys.Routing.Utils


reverse : Route -> String
reverse route =
    case route of
        LanguagesRoutes subRoute ->
            let
                parentPath =
                    matcherToPath matchersLanguages []

                subPath =
                    Languages.Routing.Utils.reverse subRoute
            in
                parentPath ++ subPath

        NotifysRoutes subRoute ->
            let
                parentPath =
                    matcherToPath matchersNotifys []

                subPath =
                    Notifys.Routing.Utils.reverse subRoute
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

        HomeRoute ->
            matcherToPath matcherHome []

        AboutRoute ->
            matcherToPath matcherAbout []

        NotFoundRoute ->
            ""
