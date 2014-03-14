{-# LANGUAGE OverloadedStrings #-}

module Shortifier(shortify) where

import Control.Applicative
import Network.HTTP
import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as BS
import qualified Data.HashMap.Strict as M

serviceUrl = "http://vldkn.net/short_links"

shortify url = do
  response <- simpleHTTP (postRequest $ requestUrl url) >>= getResponseBody
  return $ extractUrl response

requestUrl url =
  serviceUrl ++ "?value=" ++ url

extractUrl response =
  let (Just json) = decode $ BS.pack response :: Maybe (Object)
      (Just value) = M.lookup "link" json
      (String url) = value
  in url
