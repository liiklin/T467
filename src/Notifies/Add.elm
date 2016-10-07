module Notifies.Add exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias ViewModel =
    {}


view : ViewModel -> Html msg
view model =
    div [ class "col-md-12" ]
        [ Html.form [ class "form-horizontal", name "form" ]
            [ div [ class "form-group" ]
                [ label [ for "title", class "col-md-2 control-label" ] [ text "标题：" ]
                , div [ class "col-md-10" ]
                    [ input [ type' "text", class "form-control", id "title", placeholder "通知标题", pattern "^1[345678][0-9]{9}$" ] []
                    ]
                ]
            , div [ class "form-group" ]
                [ label [ for "content", class "col-md-2 control-label" ] [ text "内容：" ]
                , div [ class "col-md-10" ]
                    [ input [ type' "text", class "form-control", id "content", placeholder "通知内容" ] []
                    ]
                ]
            , div [ class "form-group" ]
                [ label [ class "col-md-2 control-label" ] [ text "置顶：" ]
                , div [ class "col-md-10" ]
                    [ div [ class "checkbox", style [ ( "padding-left", "20px" ) ] ]
                        [ input [ type' "checkbox", checked True ] []
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
