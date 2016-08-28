module Faqs.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Hop.Types exposing (Location)
import Faqs.Models exposing (FaqId, Faq, Route, Route(..))
import Faqs.Messages exposing (..)


type alias ViewModel =
    { faqs : List Faq
    , location : Location
    , route : Route
    }


view : ViewModel -> Html Msg
view model =
    div []
        [ text "12333"
        ]
