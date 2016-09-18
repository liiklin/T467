module Faqs.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Hop.Types exposing (Address)
import Faqs.Models exposing (FaqId, Faq, Route, Route(..))
import Faqs.Messages exposing (..)
import Faqs.Add


type alias ViewModel =
    { faqs : List Faq
    , location : Address
    , route : Route
    }


view : ViewModel -> Html Msg
view model =
    div []
        [ div [ class "col-md-12" ] [ button [ class "btn btn-default" ] [ text "发布新FAQ" ] ]
        , div [ class "col-md-12", style [ ( "height", "20px" ) ] ] []
        -- , Faqs.Add.view { faqs = model.faqs, location = model.location }
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
                      --     [ td [ colspan 5, class "text-center" ] [ text "暂无FAQ" ]
                      --     ]
                    ]
                ]
            ]
        ]
