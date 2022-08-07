{-# LANGUAGE ScopedTypeVariables, DataKinds #-}

module Main where

import BLAKE3
import Control.Monad
import System.Environment
import System.IO.MMap

main :: IO ()
main = do
	args <- getArgs
	let files = if (length args) > 0 then args else error "Usage: hb3sum <files>"
	forM_ files $ \file -> do
		bs <- mmapFileByteString file Nothing
		let digest :: Digest 32 = hash [bs]
		putStrLn (show digest ++ "\t" ++ file)
