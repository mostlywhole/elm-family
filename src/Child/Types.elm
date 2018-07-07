module Child.Types exposing (Model, initModel, Msg(..))


type alias Model =
    { hi_fives : Int
    , times_gifted_parent : Int
    }


initModel : Model
initModel =
    { hi_fives = 0
    , times_gifted_parent = 0
    }



{-
   Similar messages to the Parent Type.

         * Increment - Increments the bar attribute of our Child Type model
         * BringGiftToParent - Passes something random to the Parent
-}


type Msg
    = HiFive
    | BringGiftToParent Int
