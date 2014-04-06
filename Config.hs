{-# LANGUAGE DeriveGeneric #-}

module Config where

import Control.Applicative
import Data.Aeson
import Data.Maybe
import qualified Data.ByteString.Lazy as B
import Data.Text
import GHC.Generics

data Config =
  Config { uploadsPath :: !String
         , ftpHost :: !String
         , ftpUser :: !String
         , ftpPassword :: !String
         } deriving (Show, Generic)

type ConnectionConfig = (String, String, String)

instance FromJSON Config

readConfig :: FilePath -> IO Config
readConfig configPath = fromJust <$> decode <$> B.readFile configPath

connectionConfig :: Config -> ConnectionConfig
connectionConfig config =
  (host, user, password)
  where
    host = ftpHost config
    user = ftpUser config
    password = ftpPassword config
