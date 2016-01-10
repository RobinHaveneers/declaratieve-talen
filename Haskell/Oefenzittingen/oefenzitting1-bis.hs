{- OEFENING 1 -}
myLast :: [Int] -> Int
myLast [x]    = x
myLast (_:xs) = myLast xs

-- myLast = last

myRepeat :: Int -> Int -> [Int]
myRepeat 1 x = [x]
myRepeat n x = x : myRepeat (n-1) x

-- better, considering negative values

myRepeat' :: Int -> Int -> [Int]
myRepeat' n x | n > 0 = x : myRepeat' (n-1) x
              | otherwise = []

-- myRepeat = replicate

flatten :: [[Int]] -> [Int]
flatten []     = []
flatten (x:xs) = x ++ flatten xs

-- flatten = concat

range :: Int -> Int -> [Int]
range s e | s > e     = []
          | otherwise = range (s+1) e

-- range s e = [s..e]

removeMultiples :: Int -> [Int] -> [Int]
removeMultiples _ []     = []
removeMultiples a (x:xs) | x `mod` a == 0 = removeMultiples a xs
                         | otherwise      = x : removeMultiples a xs

-- removeMultiples n a = filter (\x -> mod x n /= 0) a

{- OEFENING 2 -}
mySum :: [Int] -> Int
mySum []     = 0
mySum (x:xs) = x + mySum xs

myProduct :: [Int] -> [Int]
myProduct [] = 1
