module Notifies.Messages exposing (..)

import Notifies.Models exposing (..)
import Http


type alias Prop =
    String


type alias Value =
    String


type Msg
    = Add
    | Delete NotifyId
    | Edit NotifyId
    | CancelTop NotifyId
    | SetTop NotifyId
    | Update NotifyId Prop Value
    | Cancel
    | ShowNotifies
    | FetchNotifiesFailed Http.Error
    | HandleNotifiesRetrieved (List Notify)
