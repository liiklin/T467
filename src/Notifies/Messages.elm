module Notifies.Messages exposing (..)

import Dict
import Notifies.Models exposing (..)
import Hop.Types exposing (Config, Location, Query, Router, PathMatcher, newLocation)


type alias Prop =
    String


type alias Value =
    String


type Msg
    = Show NotifyId
    | Edit NotifyId
    | Update NotifyId Prop Value
    | AddQuery (Dict.Dict String String)
    | SetQuery (Dict.Dict String String)
