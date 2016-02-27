import Text exposing (..)
import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Random exposing (..)

randomPoint : Generator (Float,Float)
randomPoint =
  pair (float -400 400) (float -300 300)

randomLevel : Generator Float
randomLevel =
  float 20 300

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

type alias Point = ( Float, Float )
spark: Point -> Float -> Form
spark coords radius =
  let grad = radial (0,0) 0 (0,0) radius [ (  0.5, rgba 200 0 0 0.5 ) , ( 1, rgba 100 0 0 0 ) ] 
  in
    circle radius
      |> gradient grad
      |> move coords


main = 
    collage 800 600 sparksList
