module Faqs.Messages exposing (..)

import Dict
import Faqs.Models exposing (..)


type alias Prop =
    String


type alias Value =
    String


type Msg
    = Show
    | Edit FaqId
    | Update FaqId Prop Value
    | AddQuery (Dict.Dict String String)
    | SetQuery (Dict.Dict String String)
