module Notifies.Messages exposing (..)

import Http
import Notifies.Models exposing (NotifyId, Notify)


type Msg
    = FetchAllDone (List Notify)
    | FetchAllFail Http.Error
    | AddNotify
    | ShowNotifies
    | EditNotify NotifyId
    | DeleteNotify NotifyId
    | ChangeTop NotifyId Bool
    | SaveNotify Notify
    | SaveSuccess Notify
    | DeleteSuccess Notify
    | SaveFail Http.Error
    -- | FormInput Field String

type Field
  = Ltitle
  | Lmessage
  | Lpinned
