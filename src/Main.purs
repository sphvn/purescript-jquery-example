module Main where

import           Data.Either
import           Prelude
import           Data.Foreign
import           Data.Foreign.Class
import           Control.Monad.Eff
import qualified Control.Monad.JQuery as J
import           Debug.Trace

main = J.ready $ do
  b <- J.body

  div <- J.create "<div>"
  input <- J.create "<input>"
  "Message: " `J.appendText` div
  input `J.append` div
  div `J.append` b

  response <- J.create "<p>"
  { color: "blue" } `J.css` response
  response `J.append` b

  flip (J.on "change") input $ \_ _ -> do
    Right msg <- read <$> J.getValue input
    J.setText ("send: " ++ msg) response