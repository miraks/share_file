import System.Environment
import System.FilePath
import Control.Applicative
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as BC
import Network.FTP.Client
import Network.FTP.Client.Parser
import ConnectionConfig
import FTPConfig

configFileName = "sharefile.conf"

withConnection :: ConnectionConfig -> (FTPConnection -> IO a) -> IO FTPResult
withConnection (ConnectionConfig host user password) f = do
  handler <- easyConnectFTP host
  login handler user (Just password) Nothing
  f handler
  quit handler

uploadFile :: FilePath -> FilePath -> FTPConnection -> IO FTPResult
uploadFile filePath uploadsPath handler = do
  cwd handler uploadsPath
  fileContent <- fmap BC.unpack $ B.readFile filePath
  let fileName = takeFileName filePath
  putbinary handler fileName fileContent

main = do
  configPath <- combine <$> (takeDirectory <$> getExecutablePath) <*> return configFileName
  config <- readFTPConfig configPath
  filePath <- head <$> getArgs
  withConnection (connectionConfig config) $ uploadFile filePath $ uploadsPath config
  putStrLn $ "http://share.vldkn.net/shares/Shared/uploads/" ++ takeFileName(filePath)
