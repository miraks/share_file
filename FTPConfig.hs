module FTPConfig where

import Control.Applicative
import ConnectionConfig

data FTPConfig = FTPConfig { connectionConfig :: ConnectionConfig
                           , uploadsPath :: FilePath
                           } deriving (Show)

readFTPConfig :: FilePath -> IO (FTPConfig)
readFTPConfig configPath = do
  (\(v1:v2:v3:v4:_) -> FTPConfig (ConnectionConfig v1 v2 v3) v4) <$> lines <$> readFile configPath
