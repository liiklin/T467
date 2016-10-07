module Faqs.Update exposing (..)

import Debug
import Navigation
import Hop exposing (makeUrl, makeUrlFromLocation, addQuery, setQuery)
import Hop.Types exposing (Config, Location)
import Routing.Config
import Models
import Faqs.Models exposing (..)
import Faqs.Messages exposing (Msg(..))
import Faqs.Routing.Utils


type alias UpdateModel =
    { faqs : List Faq
    , location : Location
    }


routerConfig : Config Models.Route
routerConfig =
    Routing.Config.config


navigationCmd : String -> Cmd a
navigationCmd path =
    Navigation.modifyUrl (makeUrl Routing.Config.config path)


update : Msg -> UpdateModel -> ( UpdateModel, Cmd Msg )
update message model =
    case Debug.log "message" message of
        Show id ->
            let
                path =
                    Faqs.Routing.Utils.reverseWithPrefix (Faqs.Models.FaqRoute id)
            in
                ( model, navigationCmd path )

        Edit id ->
            let
                path =
                    Faqs.Routing.Utils.reverseWithPrefix (Faqs.Models.FaqEditRoute id)
            in
                ( model, navigationCmd path )

        Update id prop value ->
            let
                udpatedFaqs =
                    List.map (updateWithId id prop value) model.faqs
            in
                ( { model | faqs = udpatedFaqs }, Cmd.none )

        AddQuery query ->
            let
                command =
                    model.location
                        |> addQuery query
                        |> makeUrlFromLocation routerConfig
                        |> Navigation.modifyUrl
            in
                ( model, command )

        SetQuery query ->
            let
                command =
                    model.location
                        |> setQuery query
                        |> makeUrlFromLocation routerConfig
                        |> Navigation.modifyUrl
            in
                ( model, command )


updateWithId : FaqId -> String -> String -> Faq -> Faq
updateWithId id prop value language =
    if id == language.id then
        case prop of
            "name" ->
                { language | name = value }

            _ ->
                language
    else
        language
