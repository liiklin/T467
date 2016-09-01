module Notifies.List exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, href, colspan)
import Hop.Types exposing (Location)
import Notifies.Models exposing (..)
import Notifies.Messages exposing (..)
import Date.Format
import Date


type alias ViewModel =
    { notifies : List Notify
    , location : Location
    }


view : ViewModel -> Html Msg
view model =
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
            , tbody [] (tableRows (model.notifies))
            ]
        ]


tableRows : List Notify -> List (Html Msg)
tableRows collection =
    if List.length collection > 0 then
        List.map rowView collection
    else
        [ notRowView
        ]


rowView : Notify -> Html Msg
rowView notify =
    tr []
        [ td [] [ text notify.title ]
        , td []
            [ (if notify.pinned then
                span [ class "label label-success" ]
                    [ text "已置顶" ]
               else
                span [ class "label label-warning" ]
                    [ text "取消置顶" ]
              )
            ]
        , td [] [ text (Result.withDefault "0000/00/00" (stringToDate notify.created)) ]
        , td []
            [ div [ class "btn-group" ]
                [ (if notify.pinned then
                    actionBtn (CancelTop notify.id) "btn btn-default btn-xs" "取消置顶"
                   else
                    actionBtn (SetTop notify.id) "btn btn-default btn-xs" "设置置顶"
                  )
                , actionBtn (Edit notify.id) "btn btn-default btn-xs" "编辑"
                , actionBtn (Delete notify.id) "btn btn-danger btn-xs" "删除"
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
