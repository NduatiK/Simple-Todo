import Control.Monad (forM)
import Data.List
import qualified Data.Map as Map
import Distribution.Simple.Utils (withFileContents)
import System.Directory
import System.Environment (getArgs)
import System.IO

actions :: Map.Map [Char] ([String] -> IO ())
actions =
  Map.fromList
    [ ("add", add),
      ("list", list),
      ("bump", bumpTodo),
      ("delete", deleteTodo)
    ]

add (filePath : tasks) = do
  handle <- openFile filePath AppendMode
  let tasks' = unlines tasks
  hPutStr handle tasks'
  hClose handle
  return ()
add _ = do
  return ()

list [filePath] = do
  withFileContents
    filePath
    ( \contents -> do
        let numberedTasks = zipWith (\i task -> show i ++ " - " ++ task) [1 ..] (lines contents)
        putStr (unlines numberedTasks)
    )
list _ = do
  return ()

deleteTodo :: [String] -> IO ()
deleteTodo [filePath, todoNoStr] = do
  handle <- openFile filePath ReadMode
  (tempPath, tempFileH) <- openTempFile "." "temp"
  contents <- hGetContents handle
  let todoNo = read todoNoStr :: Int
      newTodoList = filter (\(i, todo) -> i /= todoNo) (zip [1 ..] (lines contents))
      newTodoList' = map snd newTodoList
  hPutStr tempFileH $ unlines newTodoList'
  hClose handle
  hClose tempFileH
  removeFile filePath
  renameFile tempPath filePath
  return ()
deleteTodo _ = do
  return ()

bumpTodo :: [String] -> IO ()
bumpTodo [filePath, todoNoStr] = do
  handle <- openFile filePath ReadMode
  (tempPath, tempFileH) <- openTempFile "." "temp"
  contents <- hGetContents handle
  let todoNo = read todoNoStr :: Int
      newTodoList = filter (\(i, todo) -> i /= todoNo) (zip [1 ..] (lines contents))
      newTodoList' = map snd newTodoList
  hPutStr tempFileH $ unlines (lines contents !! (todoNo - 1) : newTodoList')
  hClose handle
  hClose tempFileH
  removeFile filePath
  renameFile tempPath filePath
  return ()
bumpTodo _ = do
  return ()

main = do
  file : command : args <- getArgs
  let (Just action) = Map.lookup command actions
  action (file : args)
