module Update exposing (..)

import Debug
import Navigation
import Hop exposing (makeUrl, makeUrlFromLocation, setQuery)
import Hop.Types
import Messages exposing (..)
import Models exposing (..)
import Routing.Config
import Routing.Utils
import Languages.Update
import Languages.Models
import Notifys.Update
import Notifys.Models
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
    case Debug.log "message" message of
        LanguagesMsg subMessage ->
            let
                updateModel =
                    { languages = model.languages
                    , location = model.location
                    }

                ( updatedModel, cmd ) =
                    Languages.Update.update subMessage updateModel
            in
                ( { model | languages = updatedModel.languages }, Cmd.map LanguagesMsg cmd )

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

        NotifysMsg subMessage ->
            let
                updateModel =
                    { notifys = model.notifys
                    , location = model.location
                    }

                ( updatedModel, cmd ) =
                    Notifys.Update.update subMessage updateModel
            in
                ( { model | notifys = updatedModel.notifys }, Cmd.map NotifysMsg cmd )

        SetQuery query ->
            let
                command =
                    model.location
                        |> setQuery query
                        |> makeUrlFromLocation routerConfig
                        |> Navigation.newUrl
            in
                ( model, command )

        ShowHome ->
            let
                path =
                    Routing.Utils.reverse HomeRoute
            in
                ( model, navigationCmd path )

        ShowLanguages ->
            let
                path =
                    Routing.Utils.reverse (LanguagesRoutes Languages.Models.LanguagesRoute)
            in
                ( model, navigationCmd path )

        ShowAbout ->
            let
                path =
                    Routing.Utils.reverse AboutRoute
            in
                ( model, navigationCmd path )

        ShowNotifys ->
            let
                path =
                    Routing.Utils.reverse (NotifysRoutes Notifys.Models.NotifysRoute)
            in
                ( model, navigationCmd path )

        ShowFaqs ->
            let
                path =
                    Routing.Utils.reverse (FaqsRoutes Faqs.Models.FaqsRoute)
            in
                ( model, navigationCmd path )
