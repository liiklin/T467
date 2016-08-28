module Routing.Config exposing (..)

import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)
import Models exposing (..)
import Languages.Routing.Config
import Faqs.Routing.Config
import Notifys.Routing.Config


matcherHome : PathMatcher Route
matcherHome =
    match1 HomeRoute ""


matcherAbout : PathMatcher Route
matcherAbout =
    match1 AboutRoute "/about"


matchersLanguages : PathMatcher Route
matchersLanguages =
    nested1 LanguagesRoutes "/languages" Languages.Routing.Config.matchers


matchersNotifys : PathMatcher Route
matchersNotifys =
    nested1 NotifysRoutes "/notifys" Notifys.Routing.Config.matchers


matchersFaqs : PathMatcher Route
matchersFaqs =
    nested1 FaqsRoutes "/faqs" Faqs.Routing.Config.matchers


matchers : List (PathMatcher Route)
matchers =
    [ matcherHome
    , matchersNotifys
    , matchersFaqs
    , matcherAbout
    , matchersLanguages
    ]


config : Config Route
config =
    { basePath = ""
    , hash = True
    , matchers = matchers
    , notFound = NotFoundRoute
    }
