module Notifies.Routing exposing (..)

import Notifies.Models exposing (..)
import UrlParser exposing ((</>), int, s, string)


matchers : List (UrlParser.Parser (Route -> a) a)
matchers =
    [ UrlParser.format NotifyEditRoute (int </> s "edit")
    , UrlParser.format NotifyAddRoute (s "add")
    , UrlParser.format NotifiesRoute (s "")
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
        NotifiesRoute ->
            "/"

        NotifyAddRoute ->
            "/add"

        NotifyEditRoute id ->
            "/" ++ (toS id) ++ "/edit"

        NotFoundRoute ->
            ""
