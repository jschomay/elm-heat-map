import Text exposing (..)
import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)

main = 
    collage 800 600 generateSparks

generateSparks: List Form
generateSparks =
  [ spark (100,-30) 50, spark (50, -100) 150, spark (-20, -30) 90 ]

type alias Point = ( Float, Float )
spark: Point -> Float -> Form
spark coords radius =
  circle radius
    |> gradient ( radial (0,0) 0 (0,0) radius [ (  0.5, rgba 200 0 0 0.5 ) , ( 1, rgba 100 0 0 0 ) ] )
    |> move coords
