module Notifies.Routing.Config exposing (..)

import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)
import Notifies.Models exposing (..)


matcherNotifies : PathMatcher Route
matcherNotifies =
    match1 NotifiesRoute ""


matcherNotifyAdd : PathMatcher Route
matcherNotifyAdd =
    match1 NotifyAddRoute "/add"


matcherNotifyEdit : PathMatcher Route
matcherNotifyEdit =
    match3 NotifyEditRoute "/" int "/edit"


matchers : List (PathMatcher Route)
matchers =
    [ matcherNotifies
    , matcherNotifyAdd
    , matcherNotifyEdit
    ]
