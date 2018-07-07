module Child.State exposing (update, init)

import Child.Types exposing (Model, initModel, Msg(..))
import Random


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | bar = model.bar + 1 }, giftGenerator model.bar )

        BringGiftToParent gift ->
            ( { model | times_notified_parent = model.times_notified_parent + 1 }, Cmd.none )


giftGenerator : Int -> Cmd Msg
giftGenerator current =
    if current % 2 == 0 then
        Random.generate BringGiftToParent (Random.int 1 6)
    else
        Cmd.none
