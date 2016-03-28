import Input
import View exposing (view)
import Update exposing (actions)
import Model exposing (Spark, spark)
import Update exposing (model)
import Graphics.Element exposing (Element)
import Http
import Json.Decode
import Task exposing (Task, andThen)
import Signal
import Html

get : Task Http.Error (List Spark)
get =
  Http.get (Json.Decode.list spark) "/sampledatahuge.json"

port runner : Task Http.Error ()
port runner =
  get `andThen` (Update.LoadData >> Signal.send actions.address)

port io : Signal (Task a ())
port io =
  Signal.map (Update.FilteredTime >> Signal.send actions.address) Input.filteredTime


main : Signal Graphics.Element.Element
main =
  Signal.map view model

{- TODO: 
- ~~map real data to floor plan~~
- ~~slider / auto animate through day's sound by minute/hour (need to import timestamp)~~
- toggle live sound feed or day's sound
-}
