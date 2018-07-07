module Views exposing (view)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Parent.Types exposing (Model, Msg(..))
import Child.Types


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "display", "flex" )
            , ( "flex-direction", "column" )
            , ( "justify-content", "center" )
            , ( "align-items", "center" )
            , ( "height", "300px" )
            ]
        ]
        [ div []
            [ button [ onClick Increment ] []
            , p [] [ text <| "Parent foo: " ++ toString model.foo ]
            ]
        , div []
            [ button [ onClick <| ChildMsg Child.Types.Increment ] []
            , p [] [ text <| "Child bar: " ++ toString model.child.bar ]
            ]
        , div [] [ text <| "Times Parent Notified: " ++ toString model.times_notified_by_child ]
        , div [] [ text <| "Times Child Sent Notification: " ++ toString model.child.times_notified_parent ]
        , div [] [ text <| "Parent's Gift: " ++ toString model.gift ]
        ]
