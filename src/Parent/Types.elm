module Parent.Types exposing (Model, Msg(..))

import Child.Types


{-
   Our parent model has three Integer attributes -
       * hi_fives - belongs to the parent, incremented by a parent message
       * times_notified_by_child - incremented on message from child.
       * gift - random value passed from the child

   and the model for our Child Type -
       * Child
           > hi_fives - counter for child, incremented by child message
           > times_parent_notified - incremented everytime a message is "sent" to parent
-}


type alias Model =
    { hi_fives : Int
    , times_notified_by_child : Int
    , gift : Maybe Int
    , child : Child.Types.Model
    }



{-
   We have two defined message types
       * Increment - Increments the hi_fives attribute of our Parent Type model.
       * ChildMSg - Wraps messages to and from the Child Type model.
-}


type Msg
    = HiFive
    | ChildMsg Child.Types.Msg
