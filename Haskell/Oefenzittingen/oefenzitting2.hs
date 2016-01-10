import Data.List


{-- OEFENZITTING 2 --}

{- OEFENING 1 -}
{- 1.1 -}
data Tree a = EmptyTree
            | Node a (Tree a) (Tree a)
            deriving Show

data ChessPiece = EmptyPiece
                | String (Pos -> [Pos])

{--
Je kan, als je veronderstelt dat een EmptyPiece niet bestaat,
ook het volgende schrijven

data ChessPiece = ChessPiece String (Pos -> [Pos])
--}

data Pos = Null | Pos Int Int

-- Bijvoorbeeld, voor de koningin heb je de volgende positiesfunctie

validQueenMoves :: Int -> Int -> [(Int,Int)]
validQueenMoves p q = [(p,q) | p <- [p-1,p,p+1], q <- [q-1, q, q+1], p>(-1), q>(-1)]

-- TODO NAVRAGEN OVER CHESSPIECES

data Station a b = Machine [(a,Int)] b | Series [Station a b]

-- de 'b' van de output kan weggelaten worden omwille van curried functies


{- 1.2 -}
data IntTree = EmptyIntTree
             | IntNode Integer IntTree IntTree
             deriving Show

mapIntTree::(Integer -> Integer) -> IntTree -> IntTree
mapIntTree _ EmptyIntTree = EmptyIntTree
mapIntTree f (IntNode n l r) = IntNode (f n) (mapIntTree f l) (mapIntTree f r)

intTree2list::IntTree -> [Integer]
intTree2list EmptyIntTree    = []
intTree2list (IntNode n l r) = n : (intTree2list l) ++ (intTree2list r)
{-
Handig om te weten, of te herhalen
: wordt vooral gebruikt om te pattern matchen en een 'element' toe te voegen aan een lijst
maar kan niet worden gebruikt om lijsten te concateneren
daarvoor gebruiken we ++
-}

instance Eq IntTree where
  EmptyIntTree == EmptyIntTree = True
  (IntNode v1 l1 r1) == (IntNode v2 l2 r2) = v1 == v2 && l1 == l2 && r1 == r2
  _ == _ = False

{--
Deze laatste voorwaarde _ == _ heb ik afgekeken van de oplossing. Is heel slim gezien.
Het betekent gewoon dat in alle andere gevalle de bomen niet gelijk zijn.
Noot: dit gat nog veel beter met pattern guards, en dus zonder && maar dit is eenvoudig af te leiden
--}

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree _ EmptyTree     = EmptyTree
mapTree f (Node n l r) = Node (f n) (mapTree f l) (mapTree f r)
-- TODO Vragen waarom Node hier moet gespecifieerd worden en Tree niet

instance Functor Tree where
  fmap = mapTree
-- Opnieuw, dit is gecurried

tree2list::Tree a -> [a]
tree2list EmptyTree = []
tree2list (Node n l r) = n : (tree2list l) ++ (tree2list r)

foldTree::(a -> b -> b) -> b -> Tree a -> b
foldTree f x = foldr f x . tree2list
-- TODO: Deze snap ik niet goed

instance Eq a => Eq (Tree a) where
  tree1 == tree2 = same (tree2list tree1) (tree2list tree2)

same :: Eq a => [a] -> [a] -> Bool
same t1 t2 = null (t1 \\ t2) && null (t2 \\ t1)
