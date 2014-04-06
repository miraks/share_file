module Shortifier(shortify) where

import Control.Applicative
import Network.HTTP
import Data.Aeson
import Data.Maybe
import qualified Data.ByteString.Lazy.Char8 as BS
import qualified Data.Text as T
import qualified Data.HashMap.Strict as M

shortify :: String -> String -> IO String
shortify serviceUrl url = do
  response <- simpleHTTP (postRequest $ requestUrl serviceUrl url) >>= getResponseBody
  return $ extractUrl response

requestUrl :: String -> String -> String
requestUrl serviceUrl url = serviceUrl ++ "?value=" ++ url

extractUrl :: String -> String
extractUrl response = fromJust $ decode (BS.pack response) >>= M.lookup "link"
