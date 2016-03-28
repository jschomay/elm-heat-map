module Update where

import Model exposing (Model, init, Spark)
import Signal

type Action
  = NoOp
  | LoadData (List Spark)
  | FilteredTime Int

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    LoadData heatmapData ->
      {model | heatmapData = heatmapData}

    FilteredTime at ->
      {model | filteredTime = at}

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp


model = Signal.foldp update init actions.signal
