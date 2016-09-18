module Faqs.Routing exposing (..)

import Faqs.Models exposing (..)
import UrlParser exposing ((</>), int, s, string)


matchers : List (UrlParser.Parser (Route -> a) a)
matchers =
    [ UrlParser.format FaqEditRoute (int </> s "edit")
    , UrlParser.format FaqRoute (s "/add")
    , UrlParser.format FaqsRoute (s "")
    ]


toS : a -> String
toS =
    toString


reverseWithPrefix : Route -> String
reverseWithPrefix route =
    "/notifications" ++ (reverse route)


reverse : Route -> String
reverse route =
    case route of
        FaqsRoute ->
            "/"

        FaqRoute ->
            "/add"

        FaqEditRoute id ->
            "/" ++ (toS id) ++ "/edit"

        NotFoundRoute ->
            ""
