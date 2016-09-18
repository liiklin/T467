module Update exposing (..)

import Debug
import Navigation
import Hop exposing (output, outputFromPath, setQuery)
import Hop.Types exposing (Config)
import Messages exposing (..)
import Models exposing (..)
import Routing
import Notifies.Update
import Notifies.Models
import Faqs.Update
import Faqs.Models


navigationCmd : String -> Cmd a
navigationCmd path =
    path
        |> outputFromPath Routing.config
        |> Navigation.newUrl


routerConfig : Config
routerConfig =
    Routing.config


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update message model =
    case Debug.log "main message" message of
        FaqsMsg subMessage ->
            let
                updateModel =
                    { faqs = model.faqs
                    , address = model.address
                    }

                ( updatedModel, cmd ) =
                    Faqs.Update.update subMessage updateModel
            in
                ( { model
                    | faqs = updatedModel.faqs
                  }
                , Cmd.map FaqsMsg cmd
                )

        NotifiesMsg subMessage ->
            let
                updateModel =
                    { notifies = model.notifies
                    , address = model.address
                    }

                ( updatedModel, cmd ) =
                    Notifies.Update.update subMessage updateModel
            in
                ( { model
                    | notifies = updatedModel.notifies
                  }
                , Cmd.map NotifiesMsg cmd
                )

        ShowNotifies ->
            let
                path =
                    Routing.reverse (NotifiesRoutes Notifies.Models.NotifiesRoute)
            in
                ( model, navigationCmd path )

        ShowFaqs ->
            let
                path =
                    Routing.reverse (FaqsRoutes Faqs.Models.FaqsRoute)
            in
                ( model, navigationCmd path )
