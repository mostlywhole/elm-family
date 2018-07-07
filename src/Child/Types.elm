module Child.Types exposing (Model, initModel, Msg(..))


type alias Model =
    { bar : Int
    , times_notified_parent : Int
    }


initModel : Model
initModel =
    { bar = 0
    , times_notified_parent = 0
    }



{-
   Similar messages to the Parent Type.

         * Increment - Increments the bar attribute of our Child Type model
         * BringGIftToParent - Passes something random to the Parent
-}


type Msg
    = Increment
    | BringGiftToParent Int
