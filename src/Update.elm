module Update exposing (..)

import Debug
import Navigation
import Hop exposing (makeUrl, makeUrlFromLocation, setQuery)
import Hop.Types
import Messages exposing (..)
import Models exposing (..)
import Routing.Config
import Routing.Utils
import Notifies.Update
import Notifies.Models
import Faqs.Update
import Faqs.Models


navigationCmd : String -> Cmd a
navigationCmd path =
    Navigation.newUrl (makeUrl Routing.Config.config path)


routerConfig : Hop.Types.Config Route
routerConfig =
    Routing.Config.config


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update message model =
    case Debug.log "main message" message of
        FaqsMsg subMessage ->
            let
                updateModel =
                    { faqs = model.faqs
                    , location = model.location
                    }

                ( updatedModel, cmd ) =
                    Faqs.Update.update subMessage updateModel
            in
                ( { model | faqs = updatedModel.faqs }, Cmd.map FaqsMsg cmd )

        NotifiesMsg subMessage ->
            let
                updateModel =
                    { notifies = model.notifies
                    , location = model.location
                    }

                ( updatedModel, cmd ) =
                    Notifies.Update.update subMessage updateModel
            in
                ( { model | notifies = updatedModel.notifies }, Cmd.map NotifiesMsg cmd )

        ShowNotifies ->
            let
                path =
                    Routing.Utils.reverse (NotifiesRoutes Notifies.Models.NotifiesRoute)
            in
                ( model
                , navigationCmd path
                )

        ShowFaqs ->
            let
                path =
                    Routing.Utils.reverse (FaqsRoutes Faqs.Models.FaqsRoute)
            in
                ( model, navigationCmd path )
