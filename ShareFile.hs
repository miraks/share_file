import Control.Applicative
import qualified Data.ByteString.Lazy.Char8 as B
import Network.FTP.Client
import Network.FTP.Client.Parser
import System.Environment
import System.FilePath
import Config
import Shortifier

configFileName = "sharefile_conf.json"

withConnection :: ConnectionConfig -> (FTPConnection -> IO a) -> IO FTPResult
withConnection (host, user, password) f = do
  handler <- easyConnectFTP host
  login handler user (Just password) Nothing
  f handler
  quit handler

uploadFile :: FilePath -> FilePath -> FTPConnection -> IO FTPResult
uploadFile filePath uploadsPath handler = do
  cwd handler uploadsPath
  fileContent <- B.unpack <$> B.readFile filePath
  putbinary handler (takeFileName filePath) fileContent

main = do
  configPath <- combine <$> (takeDirectory <$> getExecutablePath) <*> return configFileName
  config <- readConfig configPath
  filePath <- head <$> getArgs
  withConnection (connectionConfig config) $ uploadFile filePath $ uploadsPath config
  shortUrl <- shortify $ "http://share.vldkn.net/shares/Shared/uploads/" ++ takeFileName filePath
  putStrLn shortUrl
