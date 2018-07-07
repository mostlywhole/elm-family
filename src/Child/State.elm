module Child.State exposing (update, init)

import Child.Types exposing (Model, initModel, Msg(..))
import Random


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        {-
           We added the gift generator to give the runtime something to do
           because that's what effects are for.

           You may have come across something like

           Cmd.map (always SomeMsg) (Task.succeed ())

           Which works, but lest we forget, the model, which presumably changes,
           is already getting read by the parent. There's no need to
           pass a message to confirm the model has changed. Consider using
           recursive update calls if you want to execute a sequence of actions.

           There is however an argument for breaking down larger jobs into
           smaller chunks, but at that point you'd want to take the time to
           make your function a Task and possibly execute it as a Process.
        -}
        HiFive ->
            ( { model | hi_fives = model.hi_fives + 1 }
            , giftGenerator model.hi_fives
            )

        {-
           Kind of interesting because this message actually gets read twice.
           The first time by the Parent, the second time by the Child, assuming
           we decide to forward the message.
        -}
        BringGiftToParent gift ->
            ( { model | times_gifted_parent = model.times_gifted_parent + 1 }
            , Cmd.none
            )



{-
   We use a random generator because it conviniently fits into our motif and is
   a readily accessible effect with no external dependencies.

   A gift is sent to the parent every other hi five.

   More pragmatically, this will be an HTTP request or WebSocket message in a
   business application.
-}


giftGenerator : Int -> Cmd Msg
giftGenerator current =
    if current % 2 == 0 then
        Random.generate BringGiftToParent (Random.int 1 6)
    else
        Cmd.none
