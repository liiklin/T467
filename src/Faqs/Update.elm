module Faqs.Update exposing (..)

import Debug
import Navigation
import Hop exposing (output, outputFromPath, addQuery, setQuery)
import Hop.Types exposing (Config, Address)
import Faqs.Models exposing (..)
import Faqs.Messages exposing (Msg(..))
import Routing
import Faqs.Routing


type alias UpdateModel =
    { faqs : List Faq
    , location : Address
    }


routerConfig : Config
routerConfig =
    Routing.config


navigationCmd : String -> Cmd a
navigationCmd path =
    path
        |> outputFromPath routerConfig
        |> Navigation.modifyUrl


update : Msg -> UpdateModel -> ( UpdateModel, Cmd Msg )
update message model =
    case Debug.log "message" message of
        Show ->
            let
                path =
                    Faqs.Routing.reverseWithPrefix Faqs.Models.FaqRoute
            in
                ( model, navigationCmd path )

        Edit id ->
            let
                path =
                    Faqs.Routing.reverseWithPrefix (Faqs.Models.FaqEditRoute id)
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
                        |> output routerConfig
                        |> Navigation.modifyUrl
            in
                ( model, command )

        SetQuery query ->
            let
                command =
                    model.location
                        |> setQuery query
                        |> output routerConfig
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
