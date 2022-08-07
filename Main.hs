{-# LANGUAGE ScopedTypeVariables, DataKinds #-}

module Main where

import BLAKE3
import Control.Monad
import qualified Data.ByteString as B
import System.Environment
import System.IO.MMap

main :: IO ()
main = do
	args <- getArgs
	let files = if (length args) > 0 then args else ["/dev/stdin"]
	forM_ files $ \file -> do
		bsMapped <- mmapFileByteString file Nothing
		bs <- if B.length bsMapped > 0 then pure bsMapped else B.readFile file
		let digest :: Digest 32 = hash [bs]
		putStrLn (show digest ++ "\t" ++ file)
