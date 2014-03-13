module FTPConfig where

import Control.Applicative

data FTPConfig = FTPConfig { host :: String
                           , user :: String
                           , password :: String
                           , uploadsPath :: FilePath
                           } deriving (Show)

readFTPConfig :: FilePath -> IO (FTPConfig)
readFTPConfig configPath = do
  (\(v1:v2:v3:v4:_) -> FTPConfig v1 v2 v3 v4) <$> lines <$> readFile configPath
