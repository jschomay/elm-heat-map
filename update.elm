module Update where

import Model exposing (Model, init, Spark)
import Signal

type Action
  = NoOp
  | LoadData (List Spark)

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    LoadData model' ->
      model'

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp

model = Signal.foldp update init actions.signal
