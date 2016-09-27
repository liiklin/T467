module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Notifies.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NotifiesMsg subMsg ->
            let
                ( updatedNotifies, cmd ) =
                    Notifies.Update.update subMsg model.notifies
            in
                ( { model | notifies = updatedNotifies }, Cmd.map NotifiesMsg cmd )
