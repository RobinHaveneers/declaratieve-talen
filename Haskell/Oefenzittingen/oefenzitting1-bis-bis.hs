myLast :: [Int] -> Int
myLast [x]    = x
myLast (x:xs) = myLast xs

myRepeat :: Int -> Int -> [Int]
myRepeat 1 x = [x]
myRepeat n x = x : myRepeat (n-1) x

flatten :: [[Int]] -> [Int]
flatten [] = []
flatten (x:xs) = x ++ flatten xs

myRange :: Int -> Int -> [Int]
myRange b e | b > e = []
          | otherwise = b : myRange (b+1) e

removeMultiples :: Int -> [Int] -> [Int]
removeMultiples _ [] = []
removeMultiples n (x:xs)
  | x `mod` n  == 0 = removeMultiples n xs
  | otherwise     = x : removeMultiples n xs

---------------------------------------------

myLast2 :: [Int] -> Int
myLast2 = last

myRepeat2 :: Int -> Int -> [Int]
myRepeat2 = replicate

flatten2 :: [[Int]] -> [Int]
flatten2 = concat


myRange2 :: Int -> Int -> [Int]
myRange2 b e = [b..e]

removeMultiples2 :: Int -> [Int] -> [Int]
removeMultiples2 n l = filter (\x -> x `mod` n /= 0) l

mySum :: [Int] -> Int
mySum []     = 0
-- Overbodig: mySum [x] = x
mySum (x:xs) = x + mySum xs

myProduct :: [Int] -> Int
myProduct []     = 1
myProduct (x:xs) = x * myProduct xs

fold :: (t -> t1 -> t1) -> t1 -> [t] -> t1
fold _ b []     = b
fold f b (x:xs) = f x (fold f b xs)

-- Fuck deze functie
readInBase :: Int -> [Int] -> Int
readInBase b = foldl (\x y -> x*b+y) 0

myMap :: (a -> b) -> [a] -> [b]
myMap f []     = []
myMap f (x:xs) = f x : myMap f xs

myMapF :: (a -> b) -> [a] -> [b]
myMapF f = foldr (\x y -> f x : y) []

unpair :: [(a, b)] -> ([a], [b])
unpair l = (map fst l, map snd l)

unpairC :: [(a, b)] -> ([a], [b])
unpairC l = ([x | (x,_) <- l], [y | (_,y) <- l])

transpose :: [[b]] -> [[b]]
transpose ([]:_) = []
transpose l = map head l : transpose (map tail l)
