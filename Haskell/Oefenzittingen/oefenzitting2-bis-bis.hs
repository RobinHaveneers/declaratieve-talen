import Data.List
import Data.Char (ord, chr)


data Tree a = EmptyTree
            | TreeNode a (Tree a) (Tree a)
            deriving Show

--data ChessPiece = ChessPiece String (Pos -> Pos)

data Station a b = Machine [(a, Int)]
                 | Combination [Station a b]
                 deriving Show

machine :: [(a, Int)] -> Station a b
machine = Machine
combine :: [Station a b] -> Station a b
combine = Combination

data IntTree = EmptyIntTree
             | IntTreeNode Int IntTree IntTree
mapIntTree :: (Int -> Int) -> IntTree -> IntTree
mapIntTree _ EmptyIntTree = EmptyIntTree
mapIntTree f (IntTreeNode value left right) = IntTreeNode (f value) (mapIntTree f left) (mapIntTree f right)

intTree2list :: IntTree -> [Int]
intTree2list EmptyIntTree = []
intTree2list (IntTreeNode value left right) = value : (intTree2list left) ++ (intTree2list right)

instance Eq IntTree where
  EmptyIntTree == EmptyIntTree = True
  (IntTreeNode v1 l1 r1) == (IntTreeNode v2 l2 r2) = v1 == v2 && l1 == l2 && r1 == r2
  _ == _ = False

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree _ EmptyTree        = EmptyTree
mapTree f (TreeNode a l r) = TreeNode (f a) (mapTree f l) (mapTree f r)

instance Functor Tree where
    fmap = mapTree

tree2list :: Tree a -> [a]
tree2list EmptyTree        = []
tree2list (TreeNode a l r) = a : tree2list l ++ tree2list r

foldTree :: (a -> b -> b) -> b -> Tree a -> b
foldTree f x = foldr f x . tree2list

instance Eq a => Eq (Tree a) where
  t1 == t2 = sameElems (tree2list t1) (tree2list t2)

sameElems :: Eq a => [a] -> [a] -> Bool
sameElems x y = null (x \\ y) &&  null (y \\ x)


class Sequence a where
  next :: a -> a
  prev :: a -> a

instance Sequence Int where
  next x = x + 1
  prev x = x - 1

instance Sequence Char where
  next 'z' = error "No value after z"
  next a = chr (next (ord a))
  prev 'a' = error "No value before a"
  prev a = chr (prev (ord a))

instance Sequence Bool where
  next = not
  prev = not

class Sequence a => LeftBoundedSequence a where
  firstElem :: a

class Sequence a => RightBoundedSequence a where
  lastElem :: a

instance LeftBoundedSequence Int where
  firstElem = minBound

instance RightBoundedSequence Int where
  lastElem = maxBound

instance LeftBoundedSequence Char where
  firstElem = 'a'

instance RightBoundedSequence Char where
  lastElem = 'z'

instance LeftBoundedSequence Bool where
  firstElem = True

instance RightBoundedSequence Bool where
  lastElem = False

mapLC :: (a -> b) -> [a] -> [b]
mapLC f xs = [f x | x <- xs]

filterLC :: (a -> Bool) -> [a] -> [a]
filterLC f xs = [x | x <- xs, f x == True ]

concatLC :: [[a]] -> [a]
concatLC l = [x | y <-l, x <- y]

lc1 :: (a -> b) -> (a -> Bool) -> [a] -> [b]
lc1 f p as = [f a | a <- as, p a]

lc1M :: (a -> b) -> (a -> Bool) -> [a] -> [b]
lc1M f p as = map f $ filter p as

lc2 :: (a -> b -> c) -> [a] -> (a -> [b]) ->(b -> Bool) -> [c]
lc2 f as bf p = [f a b | a <- as, b <- bf a, p b]

applyAll :: [a -> a] -> a -> a
applyAll [] n = n
applyAll (f:fs) n = f $ applyAll fs n

applyTimes :: Int -> (a -> a) -> a -> a
applyTimes 0 _ = id
applyTimes n f = f . applyTimes (n-1) f

applyMultipleFuncs :: a-> [a -> b] -> [b]
applyMultipleFuncs n l = [f n | f<-l]   
