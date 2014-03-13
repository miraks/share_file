module ConnectionConfig where

data ConnectionConfig = ConnectionConfig { host :: String
                                         , user :: String
                                         , password :: String
                                         } deriving (Show)
