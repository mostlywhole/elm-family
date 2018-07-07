module Parent.Types exposing (Model, Msg(..))

import Child.Types


{-
   Our parent model has three Integer attributes -
       * foo - belongs to the parent, incremented by a parent message
       * times_notified_by_child - incremented on message from child.
       * gift - random value passed from the child

   and the model for our Child Type -
       * Child
           > bar - counter for child, incremented by child message
           > times_parent_notified - incremented everytime a message is "sent" to parent
-}


type alias Model =
    { foo : Int
    , times_notified_by_child : Int
    , gift : Maybe Int
    , child : Child.Types.Model
    }



{-
   We have two defined message types
       * Increment - Increments the foo attribute of our Parent Type model.
       * ChildMSg - Wraps messages to and from the Child Type model.
-}


type Msg
    = Increment
    | ChildMsg Child.Types.Msg
