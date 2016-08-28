module Notifys.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Hop.Types exposing (Location)
import Notifys.Models exposing (NotifyId, Notify, Route, Route(..))
import Notifys.Messages exposing (..)


type alias ViewModel =
    { notifys : List Notify
    , location : Location
    , route : Route
    }


view : ViewModel -> Html Msg
view model =
    div []
        [ text "12333"
        ]
