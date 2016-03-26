module Model where

import Date
import Json.Decode exposing ((:=))

type alias Spark =
  { x: Int
  , y: Int
  , level: Float
  }
  -- , timestamp: Date.Date

spark : Json.Decode.Decoder Spark
spark =
  Json.Decode.object3 Spark
    ("x" := Json.Decode.int)
    ("y" := Json.Decode.int)
    ("level" := Json.Decode.float)

type alias Model =
  List Spark

init : Model
init =
  []
