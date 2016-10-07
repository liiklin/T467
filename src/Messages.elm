module Messages exposing (..)

import Faqs.Messages
import Notifies.Messages


type Msg
    = FaqsMsg Faqs.Messages.Msg
    | NotifiesMsg Notifies.Messages.Msg
    | ShowNotifies
    | ShowFaqs
