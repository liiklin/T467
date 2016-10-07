module Faqs.Routing.Config exposing (..)

import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)
import Hop.Matchers exposing (..)
import Faqs.Models exposing (..)


matcherFaqs : PathMatcher Route
matcherFaqs =
    match1 FaqsRoute ""


matcherFaq : PathMatcher Route
matcherFaq =
    match2 FaqRoute "/" int


matcherFaqEdit : PathMatcher Route
matcherFaqEdit =
    match3 FaqEditRoute "/" int "/edit"


matchers : List (PathMatcher Route)
matchers =
    [ matcherFaqs, matcherFaq, matcherFaqEdit ]
