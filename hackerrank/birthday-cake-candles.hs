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
import Data.List
import Data.Set
import Data.Text
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe

solve :: [Int] -> Int
solve arr = Data.List.length $ Data.List.filter (== Data.List.maximum arr) arr

parseListInt :: String -> [Int]
parseListInt = Data.List.map (read :: String -> Int) . Data.List.words

readInput :: IO [Int]
readInput = void getLine >> fmap parseListInt getLine

showInt :: Int -> String
showInt = show

writeOutput :: Int -> IO ()
writeOutput = putStrLn . showInt

main :: IO ()
main = readInput >>= pure . solve >>= writeOutput
