module View exposing (..)

import Html exposing (..)
import Html.App
import Html.Events exposing (onClick)
import Html.Attributes exposing (id, class, href, style)
import Models exposing (..)
import Messages exposing (..)
import Languages.View
import Faqs.View
import Notifys.View


view : AppModel -> Html Msg
view model =
    div
        [ class "container" ]
        [ menu model
        , div [ style [ ( "padding-top", "20px" ) ] ] []
        , pageView model
        ]


menu : AppModel -> Html Msg
menu model =
    div [ class "row" ]
        [ div [ class "col-md-12" ]
            [ ul [ class "nav nav-pills" ]
                [ menuLink ShowNotifys "btnNotify" "Notify" ""
                , menuLink ShowFaqs "btnFaq" "Faq" ""
                ]
            ]
        ]


menuLink : Msg -> String -> String -> String -> Html Msg
menuLink message viewId label active =
    li [ class active ]
        [ a
            [ id viewId
            , href "javascript://"
            , onClick message
            ]
            [ text label ]
        ]


pageView : AppModel -> Html Msg
pageView model =
    case model.route of
        HomeRoute ->
            div [ class "p2" ]
                [ h1 [ id "title", class "m0" ] [ text "Home" ]
                , div [] [ text "Click on Languages to start routing" ]
                ]

        AboutRoute ->
            div [ class "p2" ]
                [ h1 [ id "title", class "m0" ] [ text "About" ]
                ]

        NotifysRoutes notifysRoute ->
            let
                viewModel =
                    { notifys = model.notifys
                    , route = notifysRoute
                    , location = model.location
                    }
            in
                div [ class "p2" ]
                    [ h1 [ id "title", class "m0" ] [ text "Notifys" ]
                    , Html.App.map NotifysMsg (Notifys.View.view viewModel)
                    ]

        FaqsRoutes faqsRoute ->
            let
                viewModel =
                    { faqs = model.faqs
                    , route = faqsRoute
                    , location = model.location
                    }
            in
                div [ class "p2" ]
                    [ h1 [ id "title", class "m0" ] [ text "Faqs" ]
                    , Html.App.map FaqsMsg (Faqs.View.view viewModel)
                    ]

        LanguagesRoutes languagesRoute ->
            let
                viewModel =
                    { languages = model.languages
                    , route = languagesRoute
                    , location = model.location
                    }
            in
                div [ class "p2" ]
                    [ h1 [ id "title", class "m0" ] [ text "Languages" ]
                    , Html.App.map LanguagesMsg (Languages.View.view viewModel)
                    ]

        NotFoundRoute ->
            notFoundView model


notFoundView : AppModel -> Html msg
notFoundView model =
    div []
        [ text "Not Found"
        ]
