module Shortifier(shortify) where

import Control.Applicative
import Network.HTTP
import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as BS
import qualified Data.Text as T
import qualified Data.HashMap.Strict as M

serviceUrl = "http://vldkn.net/short_links"

shortify :: String -> IO T.Text
shortify url = do
  response <- simpleHTTP (postRequest $ requestUrl url) >>= getResponseBody
  return $ extractUrl response

requestUrl :: String -> String
requestUrl url =
  serviceUrl ++ "?value=" ++ url

extractUrl :: String -> T.Text
extractUrl response =
  let (Just (String url)) = decode (BS.pack response) >>= M.lookup "link"
  in url
