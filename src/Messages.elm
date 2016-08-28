module Messages exposing (..)

import Hop.Types exposing (Location, Query)
import Languages.Messages
import Faqs.Messages
import Notifys.Messages


type Msg
    = SetQuery Query
    | LanguagesMsg Languages.Messages.Msg
    | FaqsMsg Faqs.Messages.Msg
    | NotifysMsg Notifys.Messages.Msg
    | ShowHome
    | ShowFaqs
    | ShowNotifys
    | ShowLanguages
    | ShowAbout
