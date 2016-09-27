module Notifies.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Notifies.Models exposing (..)
import Notifies.Messages exposing (..)


view : Notify -> Html.Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Notify -> Html.Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ backBtn ]


form : Notify -> Html.Html Msg
form notify =
    div [ class "m3" ]
        [ formContent notify ]


formContent : Notify -> Html.Html Msg
formContent notify =
    div [ class "col-md-12" ]
        [ Html.form [ class "form-horizontal", name "form" ]
            [ div [ class "form-group" ]
                [ label [ for "title", class "col-md-2 control-label" ] [ text "标题：" ]
                , div [ class "col-md-10" ]
                    [ input [ type' "text", class "form-control", id "title", placeholder "通知标题", value notify.title, pattern "^1[345678][0-9]{9}$" ] []
                    ]
                ]
            , div [ class "form-group" ]
                [ label [ for "content", class "col-md-2 control-label" ] [ text "内容：" ]
                , div [ class "col-md-10" ]
                    [ input [ type' "text", class "form-control", id "content", value notify.message, placeholder "通知内容" ] []
                    ]
                ]
            , div [ class "form-group" ]
                [ label [ class "col-md-2 control-label" ] [ text "置顶：" ]
                , div [ class "col-md-10" ]
                    [ div [ class "checkbox", style [ ( "padding-left", "20px" ) ] ]
                        [ input [ type' "checkbox", checked notify.pinned ] []
                        ]
                    ]
                ]
            ]
        , div [ class "form-group" ]
            [ div [ class "col-md-offset-2 col-md-10" ]
                [ button [ type' "submit", class "btn btn-primary", onClick (SaveNotify notify) ] [ text "提交" ]
                ]
            ]
        ]


backBtn : Html Msg
backBtn =
    button
        [ class "btn regular"
        , onClick ShowNotifies
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "返回" ]
