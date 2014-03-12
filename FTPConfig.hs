module FTPConfig where

import Control.Applicative

type FTPHost = String
type FTPUser = String
type FTPPassword = String
type FTPUploadsPath = String
data FTPConfig = FTPConfig FTPHost FTPUser FTPPassword FTPUploadsPath deriving (Show)

readFTPConfig :: FilePath -> IO (FTPConfig)
readFTPConfig configPath = do
  (\(v1:v2:v3:v4:_) -> FTPConfig v1 v2 v3 v4) <$> lines <$> readFile configPath

uploadsPath :: FTPConfig -> FTPUploadsPath
uploadsPath (FTPConfig _ _ _ path) = path
