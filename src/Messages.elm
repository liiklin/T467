module Messages exposing (..)

import Hop.Types exposing (Location, Query)
import Faqs.Messages
import Notifies.Messages


type Msg
    = SetQuery Query
    | FaqsMsg Faqs.Messages.Msg
    | NotifiesMsg Notifies.Messages.Msg
    | ShowNotifies
    | ShowFaqs
