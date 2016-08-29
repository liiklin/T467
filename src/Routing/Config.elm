module Routing.Config exposing (..)

import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)
import Models exposing (..)
import Faqs.Routing.Config
import Notifies.Routing.Config


matchersDefault : PathMatcher Route
matchersDefault =
    nested1 NotifiesRoutes "" Notifies.Routing.Config.matchers


matchersNotifies : PathMatcher Route
matchersNotifies =
    nested1 NotifiesRoutes "/notifications" Notifies.Routing.Config.matchers


matchersFaqs : PathMatcher Route
matchersFaqs =
    nested1 FaqsRoutes "/faqs" Faqs.Routing.Config.matchers


matchers : List (PathMatcher Route)
matchers =
    [ matchersNotifies
    , matchersFaqs
    , matchersDefault
    ]


config : Config Route
config =
    { basePath = "/notifications"
    , hash = True
    , matchers = matchers
    , notFound = NotFoundRoute
    }
