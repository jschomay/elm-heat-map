module Clock where

import Graphics.Collage exposing (..)
import Color exposing (white, black)

clock : Int -> Int -> Form
clock hours minutes =
  let
      r = 80
      lineStyle =
        { defaultLine
        | color = black
        , width = r/10
        , cap = Round
        }
  in group
    [ circle r |> filled white
    , circle r |> outlined lineStyle
    , segment (0,0) (0, r * 0.8)
      |> traced lineStyle
      |> rotate (degrees -(toFloat minutes * 360 / 60))
    , segment (0,0) (0, r * 0.5)
      |> traced lineStyle
      |> rotate (degrees -((toFloat hours * 360 / 12)))
      |> rotate (degrees -((toFloat minutes * 360 / 12 / 60)))
    ]

main =
  collage 200 200 [
    clock 8 12
  ]
