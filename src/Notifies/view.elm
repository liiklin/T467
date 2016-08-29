module Notifies.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Hop.Types exposing (Location)
import Notifies.Models exposing (NotifyId, Notify, Route, Route(..))
import Notifies.Messages exposing (..)


type alias ViewModel =
    { notifies : List Notify
    , location : Location
    , route : Route
    }


view : ViewModel -> Html Msg
view model =
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
                    [ label [ for "content", class "col-md-2 control-label" ] [ text "内容：" ]
                    , div [ class "col-md-10" ]
                        [ input [ type' "text", class "form-control", id "content", placeholder "通知内容", required True ] []
                        ]
                    ]
                , div [ class "form-group" ]
                    [ label [ class "col-md-2 control-label" ] [ text "置顶：" ]
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
