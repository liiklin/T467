module Notifies.Messages exposing (..)

import Notifies.Models exposing (..)


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
    -- | FormInput Field String
    -- | FormCheck Field Bool



-- | SaveAdd Notify
-- | SaveEdit Notify
