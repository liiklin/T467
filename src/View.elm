module View exposing (..)

import Html exposing (..)
import Html.App
import Html.Events exposing (onClick)
import Html.Attributes exposing (id, class, href, style)
import Models exposing (..)
import Messages exposing (..)
import Faqs.View
import Notifies.View


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
                [ menuLink ShowNotifies "btnNotifies" "通知公告" ""
                , menuLink ShowFaqs "btnFaq" "常见问题(FAQ)" ""
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
        NotifiesRoutes notifiesRoute ->
            let
                viewModel =
                    { notifies = model.notifies
                    , route = notifiesRoute
                    , location = model.location
                    }
            in
                Html.App.map NotifiesMsg (Notifies.View.view viewModel)

        FaqsRoutes faqsRoute ->
            let
                viewModel =
                    { faqs = model.faqs
                    , route = faqsRoute
                    , location = model.location
                    }
            in
                Html.App.map FaqsMsg (Faqs.View.view viewModel)

        NotFoundRoute ->
            notFoundView model


notFoundView : AppModel -> Html msg
notFoundView model =
    div [ class "row" ] [ div [ class "col-md-12" ] [ span [] [ text "没有找到对应的页面" ] ] ]
