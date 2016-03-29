module Input where

import Graphics.Element exposing (show)
import Signal
import Mouse
import Window

toHour : Int -> (Int, Int) -> Int
toHour i (w,h) =
  -- between 9 and 5, every 10 minutes
  toFloat i / toFloat w |> (*) (8 * 6)  |> (+) (9 * 6) |> round

filteredTime: Signal Int
filteredTime = Signal.map2 toHour Mouse.x Window.dimensions

main =
  Signal.map show filteredTime
