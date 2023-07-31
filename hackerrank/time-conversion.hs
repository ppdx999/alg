-- stack script --resolver ghc-9.2.8

{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use <&>" #-}

module Main where

import Control.Monad
import Data.Array
import Data.Bits
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe

data Time = Time
  { hour :: Int,
    minute :: Int,
    second :: Int
  }
  deriving (Show)

parseTime :: String -> Time
parseTime t = Time h m s
  where
    ampm = drop 8 t
    h' = read $ take 2 t :: Int
    offset
      | ampm == "PM" && h' /= 12 = 12
      | ampm == "AM" && h' == 12 = -12
      | otherwise = 0
    h = h' + offset
    m = read $ take 2 $ drop 3 t :: Int
    s = read $ take 2 $ drop 6 t :: Int

timeToString :: Time -> String
timeToString (Time h m s) = show' h ++ ":" ++ show' m ++ ":" ++ show' s
  where
    show' n = if n < 10 then '0' : show n else show n

solve :: Time -> Time
solve time = time

readInput :: IO Time
readInput = getLine >>= pure . parseTime

writeOutput :: Time -> IO ()
writeOutput = putStrLn . timeToString

main :: IO ()
main = readInput >>= pure . solve >>= writeOutput
