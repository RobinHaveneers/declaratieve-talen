ones :: [Int]
ones = 1 : ones

powers :: [Int]
powers = 1 : map (*2) powers

row :: [Int]
row = 1 : 2 : 3 : zipWith (+) (zipWith (*) (tail (tail row)) row) (tail row)
