module Routing exposing (..)

import Models exposing (..)
import Hop.Types exposing (Config)
import UrlParser exposing ((</>), oneOf, int, s)
import Notifies.Routing
import Faqs.Routing


matchers : List (UrlParser.Parser (Route -> a) a)
matchers =
    [ UrlParser.format Home (s "/")
    , UrlParser.format NotifiesRoutes (s "notifications" </> (oneOf Notifies.Routing.matchers))
    , UrlParser.format FaqsRoutes (s "faqs" </> (oneOf Faqs.Routing.matchers))
    ]


routes : UrlParser.Parser (Route -> a) a
routes =
    oneOf matchers


config : Config
config =
    { basePath = ""
    , hash = True
    }


reverse : Route -> String
reverse route =
    case Debug.log "main route" route of
        Home ->
            "/"

        NotifiesRoutes subRoute ->
            "notifications" ++ Notifies.Routing.reverse subRoute

        FaqsRoutes subRoute ->
            "faqs" ++ Faqs.Routing.reverse subRoute

        NotFoundRoute ->
            ""
