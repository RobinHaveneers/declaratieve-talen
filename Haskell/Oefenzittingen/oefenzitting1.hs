{-- OEFENZITTING 1 --}

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

myProduct :: [Int] -> Int
myProduct []     = 1
myProduct (x:xs) = x * myProduct xs

fold :: (t -> t1 -> t1) -> t1 -> [t] -> t1
fold _ n []     = n
fold f a (x:xs) = f x (fold f a xs)


-- Volgende twee zijn afgekeken van de oplossigen
readInBase :: Int -> [Int] -> Int
readInBase b = foldl (\x y -> x*b+y) 0

myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr (\x y -> f x : y) []

{- OEFENING 3 -}
unpair ::  [(a, b)] -> ([a], [b])
unpair xs = (map fst xs, map snd xs)

unpair1 :: [(t, t1)] -> ([t], [t1])
unpair1 xs = ([a | (a,_) <- xs], [b | (_,b) <- xs])

-- Volgende twee zijn afgekeken van de oplossingen
unpair2 :: [(t, t1)] -> ([t], [t1])
unpair2 [] = ([], [])
unpair2 ((a, b) : rest) = (a : as, b : bs)
  where (as, bs) = unpair rest

unpair3 :: [(t, t1)] -> ([t], [t1])
unpair3 = foldr (\(x,y) (xs,ys) -> (x:xs,y:ys)) ([],[])

{- OEFENING 4 -}
transpose' :: [[a]] -> [[a]]
transpose' ([]:_) = []
transpose' xs     = map head xs : transpose' (map tail xs)

{- OEFENING 5 -}
--sieve :: Int -> [Int]
-- Niet kunnen oplossen, zo uit het hoofd

--removeMultiples :: Int -> [Int] -> [Int]
--removeMultiples n l = filter (\x -> mod x n /= 0) l
-- Notice the possibility to perform an eta reduction here:
-- removeMultiples n = filter (\x -> mod x n /= 0)

sieve :: Int -> [Int]
sieve n = sieve2 [2..n] n

-- WITHOUT SQUARE ROOT BOUND:
-- sieve2 :: [Int] -> Int -> [Int]
-- sieve2 []     _ = []
-- sieve2 (x:xs) n = x : sieve2 (removeMultiples x xs) n

-- WITH SQUARE ROOT BOUND:
sieve2 :: [Int] -> Int -> [Int]
sieve2 (x:xs) n | x <= floorSquare n = x : sieve2 (removeMultiples x xs) n
                | otherwise           = x : xs

sqrtMono :: Double -> Double
sqrtMono = sqrt

i2d :: Int -> Double
i2d = fromIntegral

floorMono :: Double -> Int
floorMono = floor

floorSquare :: Int -> Int
floorSquare n = floorMono (sqrtMono (i2d n))
-- OR: floorSquare = floorMono . sqrtMono . i2d
