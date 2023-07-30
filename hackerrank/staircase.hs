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

solve :: Int -> [String]
solve h = Prelude.map (buildLine h) [1 .. h]

buildLine :: Int -> Int -> String
buildLine h i = Prelude.replicate (h - i) ' ' ++ Prelude.replicate i '#'

parseListInt :: String -> Int
parseListInt = read

readInput :: IO Int
readInput = getLine >>= pure . parseListInt

writeOutput :: [String] -> IO ()
writeOutput = mapM_ putStrLn

main :: IO ()
main = readInput >>= pure . solve >>= writeOutput
