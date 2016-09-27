module Notifies.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, colspan)
import Html.Events exposing (onClick)
import Notifies.Messages exposing (..)
import Notifies.Models exposing (Notify)
import Date.Format
import Date


view : List Notify -> Html Msg
view notifies =
    div [ class "col-md-12" ]
        [ div [ class "col-md-12" ]
            [ div [ class "col-md-12" ] [ actionBtn AddNotify "btn btn-default" "发布新通知" ]
            , list notifies
            ]
        ]


list : List Notify -> Html Msg
list notifies =
    div [ class "col-md-12" ]
        [ table [ class "table table-hover" ]
            [ thead []
                [ tr []
                    [ th [] [ text "标题" ]
                    , th [] [ text "置顶" ]
                    , th [] [ text "发布时间" ]
                    , th [] [ text "操作" ]
                    ]
                ]
            , tbody [] (List.map notifiesRow notifies)
            ]
        ]


notifiesRow : Notify -> Html Msg
notifiesRow notify =
    tr []
        [ td [] [ text notify.title ]
        , td []
            [ (if notify.pinned then
                span [ class "label label-success" ]
                    [ text "已置顶" ]
               else
                span [ class "label label-warning" ]
                    [ text "未置顶" ]
              )
            ]
        , td [] [ text (Result.withDefault "0000/00/00" (stringToDate notify.created)) ]
        , td []
            [ div [ class "btn-group" ]
                [ (if notify.pinned then
                    actionBtn (ChangeTop notify.id False) "btn btn-default btn-xs" "取消置顶"
                   else
                    actionBtn (ChangeTop notify.id True) "btn btn-default btn-xs" "设置置顶"
                  )
                , actionBtn (EditNotify notify.id) "btn btn-default btn-xs" "编辑"
                , actionBtn (DeleteNotify notify.id) "btn btn-danger btn-xs" "删除"
                ]
            ]
        ]


notRowView : Html msg
notRowView =
    tr []
        [ td [ colspan 5, class "text-center" ] [ text "暂无公告" ]
        ]


actionBtn : Msg -> String -> String -> Html Msg
actionBtn action css label =
    button [ class css, onClick action ]
        [ text label ]


stringToDate : String -> Result String String
stringToDate dateStr =
    Result.map
        (Date.Format.format "%Y-%m-%d %H:%M:%S")
        (Date.fromString dateStr)
