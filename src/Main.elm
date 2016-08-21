module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Navigation
import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)


--Hop.Matchers exposes functions for building route matchers

import Hop.Matchers exposing (..)


--components
-- import Components.Notify
-- ROUTES


type Route
    = FaqRoute
    | NotifyRoute
    | NotFoundRoute


matchers : List (PathMatcher Route)
matchers =
    [ match1 NotifyRoute ""
    , match1 NotifyRoute "/notifications"
    , match1 FaqRoute "/faq"
    ]


routerConfig : Config Route
routerConfig =
    { hash = False
    , basePath = "app"
    , matchers = matchers
    , notFound = NotFoundRoute
    }



-- MESSAGES


type Msg
    = NavigateTo String



-- | NotiyMsg Components.Notify.Msg
-- MODEL


type alias Model =
    { location : Location
    , route : Route
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo path ->
            let
                command =
                    makeUrl routerConfig path
                        |> Navigation.newUrl
            in
                ( model, command )


urlParser : Navigation.Parser ( Route, Hop.Types.Location )
urlParser =
    Navigation.makeParser (.href >> matchUrl routerConfig)


urlUpdate : ( Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate ( route, location ) model =
    ( { model | route = route, location = location }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ class "container" ]
        [ menu model
        , div [ style [ ( "padding-top", "20px" ) ] ] []
        , pageView model
        ]


menu : Model -> Html Msg
menu model =
    div [ class "row" ]
        [ div [ class "col-md-12" ]
            [ ul [ class "nav nav-pills" ]
                [ li [ class "active" ] [ a [ onClick (NavigateTo "notifications") ] [ text "通知公告" ] ]
                , li [] [ a [ onClick (NavigateTo "faq") ] [ text "常见问题(FAQ)" ] ]
                ]
            ]
        ]


pageView : Model -> Html Msg
pageView model =
    case model.route of
        NotifyRoute ->
            div []
                [ div [ class "col-md-12" ] [ button [ class "btn btn-default" ] [ text "发布新通知" ] ]
                , div [ class "col-md-12", style [ ( "height", "20px" ) ] ] []
                , div [ class "col-md-12" ]
                    [ Html.form [ class "form-horizontal", name "form" ]
                        [ div [ class "form-group" ]
                            [ label [ for "title", class "col-md-2 control-label" ] [ text "标题：" ]
                            , div [ class "col-md-10" ]
                                [ input [ type' "text", class "form-control", id "title", placeholder "通知标题", required True, pattern "^1[345678][0-9]{9}$" ] []
                                ]
                            ]
                        , div [ class "form-group" ]
                            [ label [ for "content", class "col-md-2 control-label" ] [ text "置顶：" ]
                            , div [ class "col-md-10" ]
                                [ input [ type' "text", class "form-control", id "content", placeholder "通知内容", required True ] []
                                ]
                            ]
                        , div [ class "form-group" ]
                            [ label [ class "col-md-2 control-label" ] [ text "内容：" ]
                            , div [ class "col-md-10" ]
                                [ div [ class "checkbox", style [ ( "padding-left", "20px" ) ] ]
                                    [ input [ type' "checkbox", checked True, required True ] []
                                    ]
                                ]
                            ]
                        ]
                    , div [ class "form-group" ]
                        [ div [ class "col-md-offset-2 col-md-10" ]
                            [ button [ type' "submit", class "btn btn-primary" ] [ text "提交" ]
                            ]
                        ]
                    ]
                , div [ class "col-md-12", style [ ( "height", "30px" ) ] ] []
                , div [ class "col-md-12" ]
                    [ table [ class "table table-hover" ]
                        [ thead []
                            [ tr []
                                [ th [] [ text "标题" ]
                                , th [] [ text "置顶" ]
                                , th [] [ text "发布时间" ]
                                , th [] [ text "操作" ]
                                ]
                            ]
                        , tbody []
                            [ tr []
                                [ td [] [ text "标题" ]
                                , td [] [ span [ class "label label-success" ] [ text "已置顶" ] ]
                                , td [] [ text "2015-10-11" ]
                                , td []
                                    [ div [ class "btn-group" ]
                                        [ button [ class "btn btn-default btn-xs" ] [ text "取消置顶" ]
                                        , button [ class "btn btn-default btn-xs" ] [ text "编辑" ]
                                        , button [ class "btn btn-danger btn-xs" ] [ text "删除" ]
                                        ]
                                    ]
                                ]
                            , tr []
                                [ td [] [ text "标题" ]
                                , td [] [ span [ class "label label-warning" ] [ text "未置顶" ] ]
                                , td [] [ text "2015-10-11" ]
                                , td []
                                    [ div [ class "btn-group" ]
                                        [ button [ class "btn btn-default btn-xs" ] [ text "设置置顶" ]
                                        , button [ class "btn btn-default btn-xs" ] [ text "编辑" ]
                                        , button [ class "btn btn-danger btn-xs" ] [ text "删除" ]
                                        ]
                                    ]
                                ]
                              -- , tr []
                              --     [ td [ colspan 5, class "text-center" ] [ text "暂无信息" ]
                              --     ]
                            ]
                        ]
                    ]
                ]

        FaqRoute ->
            div [ class "row" ]
                [ div [ class "col-md-12" ] [ button [ class "btn btn-default" ] [ text "发布新FAQ" ] ]
                , div [ class "col-md-12", style [ ( "height", "20px" ) ] ] []
                , div [ class "col-md-12" ]
                    [ Html.form [ class "form-horizontal", name "form" ]
                        [ div [ class "form-group" ]
                            [ label [ for "question", class "col-md-2 control-label" ] [ text "问题：" ]
                            , div [ class "col-md-10" ]
                                [ input [ type' "text", class "form-control", id "question", placeholder "问题", required True ] []
                                ]
                            ]
                        , div [ class "form-group" ]
                            [ label [ for "priority", class "col-md-2 control-label" ] [ text "优先级：" ]
                            , div [ class "col-md-10" ]
                                [ input [ type' "number", class "form-control", id "priority", placeholder "优先级(整数)", required True ] []
                                ]
                            ]
                        , div [ class "form-group" ]
                            [ label [ for "answer", class "col-md-2 control-label" ] [ text "答案：" ]
                            , div [ class "col-md-10" ]
                                [ textarea [ class "form-control", id "answer", placeholder "答案", rows 5, required True ] []
                                ]
                            ]
                        ]
                    , div [ class "form-group" ]
                        [ div [ class "col-md-offset-2 col-md-10" ]
                            [ button [ type' "submit", class "btn btn-primary" ] [ text "提交" ]
                            ]
                        ]
                    ]
                , div [ class "col-md-12", style [ ( "height", "30px" ) ] ] []
                , div [ class "col-md-12" ]
                    [ table [ class "table table-hover" ]
                        [ thead []
                            [ tr []
                                [ th [] [ text "问题" ]
                                , th [] [ text "状态" ]
                                , th [] [ text "优先级" ]
                                , th [] [ text "发布时间" ]
                                , th [] [ text "操作" ]
                                ]
                            ]
                        , tbody []
                            [ tr []
                                [ td [] [ text "标题" ]
                                , td [] [ span [ class "label label-success" ] [ text "已发布" ] ]
                                , td [] [ text "1" ]
                                , td [] [ text "2015-10-11" ]
                                , td []
                                    [ div [ class "btn-group" ]
                                        [ button [ class "btn btn-default btn-xs" ] [ text "取消发布" ]
                                        , button [ class "btn btn-default btn-xs" ] [ text "编辑" ]
                                        , button [ class "btn btn-danger btn-xs" ] [ text "删除" ]
                                        ]
                                    ]
                                ]
                            , tr []
                                [ td [] [ text "标题" ]
                                , td [] [ span [ class "label label-warning" ] [ text "未发布" ] ]
                                , td [] [ text "2" ]
                                , td [] [ text "2015-10-11" ]
                                , td []
                                    [ div [ class "btn-group" ]
                                        [ button [ class "btn btn-default btn-xs" ] [ text "确定发布" ]
                                        , button [ class "btn btn-default btn-xs" ] [ text "编辑" ]
                                        , button [ class "btn btn-danger btn-xs" ] [ text "删除" ]
                                        ]
                                    ]
                                ]
                              -- , tr []
                              --     [ td [ colspan 5, class "text-center" ] [ text "暂无信息" ]
                              --     ]
                            ]
                        ]
                    ]
                ]

        NotFoundRoute ->
            div [ class "row" ] [ div [ class "col-md-12" ] [ text "没有知道对应的页面" ] ]



-- notifyView : Model -> Html Msg
-- notifyView model =
--     Components.Notify.view ""
-- APP


init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init ( route, location ) =
    ( Model location route, Cmd.none )


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = (always Sub.none)
        }
