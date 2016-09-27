module Models exposing (..)

import Notifies.Models exposing (Notify)
import Routing


type alias Model =
    { notifies : List Notify
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { notifies = []
    , route = route
    }
