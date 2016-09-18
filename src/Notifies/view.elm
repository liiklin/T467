module Notifies.View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Hop.Types exposing (Address)
import Notifies.Models exposing (NotifyId, Notify, Route, Route(..))
import Notifies.Messages exposing (..)
import Notifies.Add
import Notifies.Edit
import Notifies.List


type alias ViewModel =
    { notifies : List Notify
    , address : Address
    , route : Route
    }


view : ViewModel -> Html Msg
view model =
    div []
        [ div [ class "col-md-12" ] [ menuBtnView model ]
        , div [ class "col-md-12", style [ ( "height", "20px" ) ] ] []
        , subView model
        , div [ class "col-md-12", style [ ( "height", "30px" ) ] ] []
        , Notifies.List.view { notifies = model.notifies, address = model.address }
        ]



-- 按钮


menuBtnView : ViewModel -> Html Msg
menuBtnView model =
    case model.route of
        NotifyAddRoute ->
            button [ class "btn btn-default", onClick Cancel ] [ text "取消发布" ]

        NotifyEditRoute notifyId ->
            button [ class "btn btn-default", onClick Cancel ] [ text "取消修改" ]

        NotifiesRoute ->
            button [ class "btn btn-default", onClick Add ] [ text "发布新通知" ]

        NotFoundRoute ->
            button [ class "btn btn-default", onClick Add ] [ text "发布新通知" ]



-- 列表视图


subView : ViewModel -> Html Msg
subView model =
    case model.route of
        NotifyAddRoute ->
            Notifies.Add.view {}

        NotifyEditRoute notifyId ->
            let
                maybeLanguage =
                    getNotify model.notifies notifyId
            in
                case maybeLanguage of
                    Just notify ->
                        Notifies.Edit.view notify

                    _ ->
                        notFoundView model

        NotifiesRoute ->
            emptyView

        NotFoundRoute ->
            notFoundView model


emptyView : Html msg
emptyView =
    span [] []


notFoundView : ViewModel -> Html msg
notFoundView model =
    div [ class "col-md-12" ]
        [ span []
            [ text "没有找到对应页面"
            ]
        ]


getNotify : List Notify -> NotifyId -> Maybe Notify
getNotify notifies id =
    notifies
        |> List.filter (\notify -> notify.id == id)
        |> List.head
