module App exposing (..)

import Html exposing (program)
import Parent.State exposing (init, update, sub)
import Parent.Types exposing (Model, Msg)
import Views exposing (view)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = sub
        }
