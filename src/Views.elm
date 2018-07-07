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
        [ div
            [ style [ ( "align-items", "left" ) ]
            ]
            [ table []
                [ tr []
                    [ td []
                        [ button
                            [ style [ ( "float", "left" ) ]
                            , onClick HiFive
                            ]
                            [ text "+" ]
                        , div [ style [ ( "float", "right" ) ] ]
                            [ text "Parent Hi Fives " ]
                        ]
                    , td [] [ div [] [ text <| toString model.hi_fives ] ]
                    ]
                , tr []
                    [ td []
                        [ button
                            [ style [ ( "float", "left" ) ]
                            , onClick <| ChildMsg Child.Types.HiFive
                            ]
                            [ text "+" ]
                        , div [ style [ ( "float", "right" ) ] ]
                            [ text "Child Hi Fives " ]
                        ]
                    , td [] [ div [] [ text <| toString model.child.hi_fives ] ]
                    ]
                , tr []
                    [ td [] [ text <| "Times Child Sent Gift " ]
                    , td [] [ text <| toString model.child.times_gifted_parent ]
                    ]
                , tr []
                    [ td [] [ text <| "Times Parent Gifted " ]
                    , td [] [ text <| toString model.times_notified_by_child ]
                    ]
                , tr []
                    [ td [] [ text <| "Parent's Gift " ]
                    , td [] [ text <| toString model.gift ]
                    ]
                ]
            ]
        ]
