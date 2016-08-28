module Faqs.Messages exposing (..)

import Dict
import Faqs.Models exposing (..)
import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)


type alias Prop =
    String


type alias Value =
    String


type Msg
    = Show FaqId
    | Edit FaqId
    | Update FaqId Prop Value
    | AddQuery (Dict.Dict String String)
    | SetQuery (Dict.Dict String String)
