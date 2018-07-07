module Parent.State exposing (init, update, sub)

import Parent.Types exposing (Model, Msg(..))
import Child.State
import Child.Types


{-
   Pretty standard boiler plate. We call the child's init function to give us an
   initiated model.

   We could also initiate it by direct assignment, since Child.init doesn't fire
   off any effects.
-}


init : ( Model, Cmd Msg )
init =
    let
        ( child_model, child_cmd_msg ) =
            Child.State.init
    in
        ( { hi_fives = 0
          , times_notified_by_child = 0
          , child = child_model
          , gift = Nothing
          }
        , Cmd.map ChildMsg child_cmd_msg
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HiFive ->
            ( { model | hi_fives = model.hi_fives + 1 }, Cmd.none )

        ChildMsg msg_ ->
            case msg_ of
                {-
                   We can react to specific messages from the child. In this
                   example, BringGiftToParent Int has a very specific purpose.

                   For larger applications, you might use something like
                   ChildMessageForParent ChildParentMsg and then match against
                   ChildParentMsg

                   While we're at it though, we could also just inspect the
                   model. In other cases, we can actually have no model and
                   pass data through messages entirely! Frankly, I haven't
                   benchmarked it but it seemingly makes more sense than
                   dropping a model after pulling the data every time.
                -}
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

                {-
                   This is the base case. The idea is we only care about changing
                   the child model and any additional effects that need to be
                   run are pushed back through the child's update function.

                   Typically this will end up being Cmd.map ChildMsg Cmd.none -
                   which ends up resolving to ( <model stuff>, Cmd.none)
                -}
                _ ->
                    let
                        ( child_model, child_cmd_msg ) =
                            Child.State.update msg_ model.child
                    in
                        ( { model | child = child_model }, Cmd.map ChildMsg child_cmd_msg )


sub : Model -> Sub Msg
sub model =
    Sub.none
