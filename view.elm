module View where

import Heatmap exposing (heatmap)
import Model exposing (Model)
import Update exposing (model)
import Graphics.Collage exposing (toForm, Form)
import Graphics.Element exposing (show)
import Window
import Signal
import Html exposing (..)

view : Model -> Graphics.Element.Element
view model =
  heatmap model
