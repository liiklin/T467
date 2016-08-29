module Models exposing (..)

import Hop.Types exposing (Location, newLocation)
import Faqs.Models exposing (Faq, faqs)
import Notifies.Models exposing (Notify, notifies)


type Route
    = NotifiesRoutes Notifies.Models.Route
    | FaqsRoutes Faqs.Models.Route
    | NotFoundRoute


type alias AppModel =
    { notifies : List Notify
    , faqs : List Faq
    , location : Location
    , route : Route
    , selectedFaq : Maybe Faq
    , selectedNotify : Maybe Notify
    }


newAppModel : Route -> Hop.Types.Location -> AppModel
newAppModel route location =
    { notifies = notifies
    , faqs = faqs
    , location = location
    , route = route
    , selectedFaq = Maybe.Nothing
    , selectedNotify = Maybe.Nothing
    }
