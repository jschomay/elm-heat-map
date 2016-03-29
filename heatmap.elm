module Heatmap where

import Model exposing (Spark)
import Text exposing (..)
import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import List

type alias Point = ( Int, Int )

spark: Point -> Float -> Form
spark (x, y) radius =
  circle radius
    |> filled orange
    |> alpha 0.2
    |> move (toFloat x, toFloat y)

floorplan: Int -> Int -> Form
floorplan w h =
  -- note, the image is not included in the repo for security reasons
  -- download it from the tracker/gachan repo
  (image w h "/floorplan.png")
    |> toForm

sparks : Int -> Int -> List Spark -> List Form
sparks w h =
  let toSpark s =
    let {x, y, level} = s
    in spark ((round (toFloat x - toFloat w/2)), -(round (toFloat y - toFloat h/2))) (level * 1500)
  in List.map toSpark

heatmap : List Spark -> Form
heatmap sparksData =
  let w = 2789
      h = 806
  in group
    [ floorplan w h
    , group (sparks w h sparksData)
    ]
