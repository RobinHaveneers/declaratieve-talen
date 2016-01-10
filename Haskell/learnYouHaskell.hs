import Control.Monad
import Data.Char

-- Starting out
doubleMe x = x + x
doubleUsSimple x y = x*2 + y*2
doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                      then x
                      else x*2

doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

conanO'Brien = "It's a-me, Conan O'Brien!"

rightTrianlges = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24 ]

-- Types & typeclasses
removeNonUppercase :: String -> String
removeNonUppercase st = [c | c <- st, elem c ['A' .. 'Z']]

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

factorial :: Integer -> Integer
factorial n  = product [1..n]

sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

joinArgs :: (a -> Bool) -> (a -> Bool) -> (a -> Bool)
joinArgs f g x = f x && g x


data Shape = Circle {
     xCoCenter :: Float,
     yCoCenter :: Float,
     radius    :: Float
 } |  Rectangle {
     leftX :: Float,
     leftY :: Float,
     rightX :: Float,
     rightY :: Float
     }

foreverPrint = forever $ do  
  putStr "Give me some input: "
  l <- getLine
  putStrLn $ map toUpper l
