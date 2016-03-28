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
          Just t -> Date.hour t == time
          Nothing -> False

  in flow down
     [ "Office sound levels from " ++ toString filteredTime ++ ":00 to " ++ toString (filteredTime + 1) ++ ":00 (move mouse from left to right to change time)" |> show
    , heatmap <| List.filter (at filteredTime) heatmapData
    ]
