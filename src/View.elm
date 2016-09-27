module View exposing (..)

import Html exposing (Html, div, text, span, button)
import Html.Attributes exposing (id, class, href, style)
import Html.Events exposing (onClick)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Notifies.Add
import Notifies.List
import Notifies.Edit
import Notifies.Models exposing (NotifyId)
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "col-md-12", style [ ( "height", "30px" ) ] ] []
        , div [ class "col-md-12" ] [ listView model ]
        ]


listView : Model -> Html Msg
listView model =
    case Debug.log "model.route" model.route of
        NotifiesRoute ->
            Html.App.map NotifiesMsg (Notifies.List.view model.notifies)

        NotifyRoute id ->
            notifyEditPage model id

        AddNotifyRoute ->
            Html.App.map NotifiesMsg (Notifies.Add.view Notifies.Models.notify)

        NotFoundRoute ->
            notFoundView


notifyEditPage : Model -> NotifyId -> Html Msg
notifyEditPage model notifyId =
    let
        maybeNotify =
            model.notifies
                |> List.filter (\notify -> notify.id == notifyId)
                |> List.head
    in
        case maybeNotify of
            Just notify ->
                Html.App.map NotifiesMsg (Notifies.Edit.view notify)

            Nothing ->
                Html.App.map NotifiesMsg (Notifies.List.view model.notifies)


notFoundView : Html msg
notFoundView =
    div [ class "row" ]
        [ div [ class "col-md-12" ]
            [ span []
                [ text "没有找到对应的页面2"
                ]
            ]
        ]
