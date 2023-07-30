-- stack script --resolver ghc-9.2.8

{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}

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

solve :: [Int] -> [Int]
solve arr = do
  let sorted = Data.List.sort arr
  let min = Data.List.sum $ Data.List.take 4 sorted
  let max = Data.List.sum $ Data.List.drop 1 sorted
  [min, max]

parseInput :: String -> [Int]
parseInput = Data.List.map (read :: String -> Int) . Data.List.words

buildOutput :: [Int] -> String
buildOutput = Data.List.unwords . Data.List.map show

answer :: String -> String
answer = buildOutput . solve . parseInput

main :: IO ()
main = getLine >>= putStrLn . answer
