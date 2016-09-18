module Faqs.Add exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, placeholder, name, id, for, type', rows)
import Hop.Types exposing (Address)
import Dict
import Faqs.Models exposing (..)
import Faqs.Messages exposing (..)


type alias ViewModel =
    { faqs : List Faq
    , location : Address
    }


view : ViewModel -> Html Msg
view model =
    div [ class "col-md-12" ]
        [ Html.form [ class "form-horizontal", name "form" ]
            [ div [ class "form-group" ]
                [ label [ for "question", class "col-md-2 control-label" ] [ text "问题：" ]
                , div [ class "col-md-10" ]
                    [ input [ type' "text", class "form-control", id "question", placeholder "问题" ] []
                    ]
                ]
            , div [ class "form-group" ]
                [ label [ for "priority", class "col-md-2 control-label" ] [ text "优先级：" ]
                , div [ class "col-md-10" ]
                    [ input [ type' "number", class "form-control", id "priority", placeholder "优先级(整数)" ] []
                    ]
                ]
            , div [ class "form-group" ]
                [ label [ for "answer", class "col-md-2 control-label" ] [ text "答案：" ]
                , div [ class "col-md-10" ]
                    [ textarea [ class "form-control", id "answer", placeholder "答案", rows 5 ] []
                    ]
                ]
            ]
        , div [ class "form-group" ]
            [ div [ class "col-md-offset-2 col-md-10" ]
                [ button [ type' "submit", class "btn btn-primary" ] [ text "提交" ]
                ]
            ]
        ]
