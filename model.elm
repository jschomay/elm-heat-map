module Model where

import Date
import Json.Decode exposing ((:=))

type alias Spark =
  { x: Int
  , y: Int
  , level: Float
  , timestamp: Maybe Date.Date
  }

spark : Json.Decode.Decoder Spark
spark =
  Json.Decode.object4 Spark
    ("x" := Json.Decode.int)
    ("y" := Json.Decode.int)
    ("level" := Json.Decode.float)
    (Json.Decode.map (Date.fromString >> Result.toMaybe) ("timestamp" := Json.Decode.string))

type alias Model =
  { filteredTime : Int
  , heatmapData : List Spark
  }

init : Model
init =
  { filteredTime = 10
  , heatmapData = []
  }
