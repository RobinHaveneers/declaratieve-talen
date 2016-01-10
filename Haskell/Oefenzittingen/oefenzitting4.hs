import Control.Monad
import Data.List

program1 :: IO()
program1 =
  do m <- (liftM read getLine::IO Int)
     -- eerste en tweede inlezing zijn hetzelfde alleen anders geschreven
     n <- bind getLine (return . read) :: IO Int
     -- dit is hetzelfde:
     n <- bind (getLine) (\s -> return (read s)) :: IO Int
     -- of gewoon met liftM
     -- n <- (liftM read getLine::IO Int)
     replicateM_ m (print n)

bind = (>>=)

program2 :: IO()
program2 = do
  line <- getLine
  if null line
    then return ()
    else do
      putStrLn (reverse line)
      program2

program2' :: IO()
program2' = do
  line <- getLine
  when (not $ null line) $ do
    putStrLn $ reverse line
    program2'




-- Uitbreiding: boundaries checking
-- Vul array met 'return "Hello World"' etc. om 'Just "Hello World"' te krijgen
index :: [IO a] -> IO Int -> IO (Maybe a)
index l ioint = do
  int <- ioint
  if (int < length l)
    then liftM Just $ l !! (int-1)
    else return Nothing
