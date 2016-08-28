module Models exposing (..)

import Hop.Types exposing (Location, newLocation)
import Languages.Models exposing (Language, languages)
import Faqs.Models exposing (Faq, faqs)
import Notifys.Models exposing (Notify, notifys)


type Route
    = HomeRoute
    | AboutRoute
    | NotifysRoutes Notifys.Models.Route
    | FaqsRoutes Faqs.Models.Route
    | LanguagesRoutes Languages.Models.Route
    | NotFoundRoute


type alias AppModel =
    { languages : List Language
    , notifys : List Notify
    , faqs : List Faq
    , location : Location
    , route : Route
    , selectedLanguage : Maybe Language
    }


newAppModel : Route -> Hop.Types.Location -> AppModel
newAppModel route location =
    { languages = languages
    , notifys = notifys
    , faqs = faqs
    , location = location
    , route = route
    , selectedLanguage = Maybe.Nothing
    }
