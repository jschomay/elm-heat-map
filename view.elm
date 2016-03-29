module View where

import Heatmap exposing (heatmap)
import Model exposing (Model)
import Update exposing (model)
import Graphics.Collage exposing (toForm, Form)
import Graphics.Element exposing (flow, down, show)
import Window
import Signal
import List
import Html exposing (..)
import Date

view : Model -> Graphics.Element.Element
view {filteredTime, heatmapData} =
  let
      getTimestamp m =
        case m.timestamp of
          Just t -> Date.hour t
          Nothing -> -1

      at time m =
        case m.timestamp of
          Just t -> Date.hour t == getHours time && Date.minute t == getMinutes time
          Nothing -> False

      filteredHeatMapData =
        List.filter (at filteredTime) heatmapData

      getHours time =
        (truncate (toFloat time / 6))

      getMinutes time =
        rem time 6

      samplesCount =
        List.foldl ((+) << (always 1)) 0 filteredHeatMapData 

      displayTime inMinutes =
        (toString <| getHours inMinutes) ++ ":" ++ ( toString <| getMinutes inMinutes)

  in flow down
     [ "Office sound levels from " ++ displayTime filteredTime ++ "0 to " ++ displayTime (filteredTime + 1) ++ "0 (move mouse from left to right to change time)" |> show
    , heatmap filteredHeatMapData
    ]
