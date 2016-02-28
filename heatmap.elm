import Text exposing (..)
import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Random exposing (..)

randomPoint : Generator (Int, Int)
randomPoint =
  pair (int -300 300) (int -400 400)

randomLevel : Generator Int
randomLevel =
  int  20 300

generateSpark: Int -> Form
generateSpark seed =
  let ( ( coords, _ ), ( level, _ ) ) = ( generate randomPoint <| initialSeed seed, generate randomLevel <| initialSeed seed)
  in
    spark coords level

sparksList: List Form
sparksList =
  [
    generateSpark 1,
    generateSpark 2,
    generateSpark 3,
    generateSpark 4,
    generateSpark 5,
    generateSpark 6
  ]

type alias Point = ( Int, Int )
spark: Point -> Int -> Form
spark (x, y) radius =
  let grad = radial (0,0) 0 (0,0) ( toFloat radius ) [ (  0.5, rgba 200 0 0 0.5 ) , ( 1, rgba 100 0 0 0 ) ] 
  in
    circle ( toFloat radius )
      |> gradient grad
      |> move (toFloat x, toFloat y)

blueprint: Int -> Int -> Form
blueprint w h =
  rect ( toFloat w ) ( toFloat h )
    |> outlined ( { defaultLine | width = 2 } )


main = 
  let
      w = 800
      h = 600
  in
     collage w h ( [ blueprint w h ] ++ sparksList )
