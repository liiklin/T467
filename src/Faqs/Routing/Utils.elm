module Faqs.Routing.Utils exposing (..)

import Hop exposing (..)
import Hop.Types exposing (Config)
import Models
import Faqs.Models exposing (..)
import Routing.Config
import Faqs.Routing.Config exposing (..)


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
        FaqsRoute ->
            matcherToPath matcherFaqs []

        FaqRoute id ->
            matcherToPath matcherFaq [ toS id ]

        FaqEditRoute id ->
            matcherToPath matcherFaqEdit [ toS id ]

        NotFoundRoute ->
            ""
