module Parent.State exposing (init, update, sub)

import Parent.Types exposing (Model, Msg(..))
import Child.State
import Child.Types


init : ( Model, Cmd Msg )
init =
    let
        ( child_model, child_cmd_msg ) =
            Child.State.init
    in
        ( { foo = 0, times_notified_by_child = 0, child = child_model, gift = Nothing }, Cmd.map ChildMsg child_cmd_msg )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | foo = model.foo + 1 }, Cmd.none )

        ChildMsg msg_ ->
            case msg_ of
                Child.Types.BringGiftToParent gift ->
                    let
                        ( child_model, child_cmd_msg ) =
                            Child.State.update msg_ model.child
                    in
                        ( { model
                            | child = child_model
                            , times_notified_by_child = model.times_notified_by_child - 1
                            , gift = Just gift
                          }
                        , Cmd.map ChildMsg child_cmd_msg
                        )

                _ ->
                    let
                        ( child_model, child_cmd_msg ) =
                            Child.State.update msg_ model.child
                    in
                        ( { model | child = child_model }, Cmd.map ChildMsg child_cmd_msg )


sub : Model -> Sub Msg
sub model =
    Sub.none
