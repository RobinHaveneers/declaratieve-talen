import Control.Applicative (Applicative(..))
import Control.Monad (liftM2, join, ap)

sumABC :: [(String, Int)] -> Maybe Int
sumABC l = case lookup "A" l of
           Nothing -> Nothing
           Just a  -> case lookup "B" l of
                     Nothing -> Nothing
                     Just b  -> case lookup "C" l of
                                Nothing -> Nothing
                                Just c  -> Just (a + b + c)

sumABCBind :: [(String, Int)] -> Maybe Int
sumABCBind l = lookup "A" l >>= \x ->
               lookup "B" l >>= \y ->
               lookup "C" l >>= \z ->
               return (x+y+z)

sumABCDo :: [(String, Int)] -> Maybe Int
sumABCDo l = do
              x <- lookup "A" l
              y <- lookup "B" l
              z <- lookup "C" l
              return (x+y+z)

data Identity a = Identity a deriving Show

instance Functor Identity where
  fmap f (Identity x) = Identity (f x)

data Pair a b = Pair a b deriving Show
instance Functor (Pair a) where
 fmap f (Pair b a) = Pair b (f a)

data Unit a = Unit deriving Show

instance Functor Unit where
 fmap f Unit = Unit

data MayFail e a = Error e | Result a
 deriving (Show)

safeDiv :: Int -> Int -> MayFail String Int
safeDiv a b
  | b == 0 = Error "Division by zero"
  | otherwise = Result (div a b)

instance Functor (MayFail e) where
  fmap f (Error e) = Error e
  fmap f (Result a) = Result (f a)

instance Monad (MayFail e) where
  return = Result
  Error e >>= f = Error e
  Result a >>= f = f a

-- Required for GHC version >= 7.10
instance Applicative (MayFail e) where
  pure = return
  (<*>) = ap

data Exp = Lit Int | Add Exp Exp | Mul Exp Exp | Div Exp Exp
  deriving (Show)

eval :: Exp -> MayFail String Int
eval (Lit x)    = return x
eval (Add x y ) = eval x >>= \xv ->
                  eval y >>= \yv ->
                  return (xv + yv)
eval (Mul x y)  = eval x >>= \xv ->
                  eval y >>= \yv ->
                  return (xv + yv)
eval (Div x y)  = eval x >>= \xv ->
                  eval y >>= \yv ->
                  safeDiv xv yv

evalDo :: Exp -> MayFail String Int
evalDo (Lit x)    = return x
evalDo (Add x y ) = do
                  xv <- eval x
                  yv <- eval y
                  return (xv + yv)
evalDo (Mul x y)  = do
                  xv <- eval x
                  yv <- eval y
                  return (xv + yv)
evalDo (Div x y)  = do
                  xv <- eval x
                  yv <- eval y
                  safeDiv xv yv
