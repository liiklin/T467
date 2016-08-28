module Notifys.Routing.Config exposing (..)

import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)
import Notifys.Models exposing (..)


matcherNotifys : PathMatcher Route
matcherNotifys =
    match1 NotifysRoute ""


matcherNotify : PathMatcher Route
matcherNotify =
    match2 NotifyRoute "/" int


matcherNotifyEdit : PathMatcher Route
matcherNotifyEdit =
    match3 NotifyEditRoute "/" int "/edit"


matchers : List (PathMatcher Route)
matchers =
    [ matcherNotifys, matcherNotify, matcherNotifyEdit ]
