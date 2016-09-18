module Models exposing (..)

import Hop.Types exposing (Address, newAddress)
import Faqs.Models exposing (Faq, faqs)
import Notifies.Models exposing (Notify, notifies)


type Route
    = NotifiesRoutes Notifies.Models.Route
    | FaqsRoutes Faqs.Models.Route
    | NotFoundRoute


type alias AppModel =
    { notifies : List Notify
    , faqs : List Faq
    , address : Address
    , route : Route
    }


newAppModel : Route -> Address -> AppModel
newAppModel route address =
    { notifies = notifies
    , faqs = faqs
    , address = address
    , route = route
    }
