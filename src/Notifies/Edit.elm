module Notifies.Edit exposing (..)

import Html exposing (..)
import Html.Events exposing (on, targetValue, targetChecked, onCheck)
import Html.Attributes exposing (..)
import Json.Decode as Json
import Notifies.Models exposing (..)
import Notifies.Messages exposing (..)


view : Notify -> Html Msg
view model =
    div [ class "col-md-12" ]
        [ Html.form [ class "form-horizontal", name "form" ]
            [ div [ class "form-group" ]
                [ label [ for "title", class "col-md-2 control-label" ] [ text "标题：" ]
                , div [ class "col-md-10" ]
                    [ input
                        [ type' "text"
                        , class "form-control"
                        , id "title"
                        , placeholder "通知标题"
                        , pattern "^1[345678][0-9]{9}$"
                        , value model.title
                        ]
                        []
                    ]
                ]
            , div [ class "form-group" ]
                [ label
                    [ for "content"
                    , class "col-md-2 control-label"
                    ]
                    [ text "内容：" ]
                , div [ class "col-md-10" ]
                    [ input
                        [ type' "text"
                        , class "form-control"
                        , id "content"
                        , placeholder "通知内容"
                        , value model.message
                        , on "input" (Json.map (Update model.id "title") targetValue)
                        ]
                        []
                    ]
                ]
            , div [ class "form-group" ]
                [ label [ class "col-md-2 control-label" ] [ text "置顶：" ]
                , div [ class "col-md-10" ]
                    [ div
                        [ class "checkbox"
                        , style [ ( "padding-left", "20px" ) ]
                        ]
                        [ input
                            [ type' "checkbox"
                            , id "pinned"
                            , checked model.pinned
                            ]
                            []
                        ]
                    ]
                ]
            ]
        , div [ class "form-group" ]
            [ div [ class "col-md-offset-2 col-md-10" ]
                [ button [ type' "submit", class "btn btn-primary" ] [ text "确定" ]
                ]
            ]
        ]
