module View where

import Clock
import Heatmap exposing (heatmap)
import Model exposing (Model)
import Update exposing (model)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (flow, down, show)
import Window
import Signal
import List
import Html exposing (..)
import Date

view : (Int, Int) -> Model -> Graphics.Element.Element
view (w, h) {filteredTime, heatmapData} =
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
     , collage w h
       [ heatmap filteredHeatMapData
         |> move (-(toFloat w / 3), 0)
       , Clock.clock (getHours filteredTime) (getMinutes filteredTime * 10)
         |> move (-(toFloat w / 2 - 100), toFloat h / 2 - 100)
       ]
     ]
