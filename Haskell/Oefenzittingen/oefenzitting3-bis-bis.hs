sumABC :: [(String, Int)] -> Maybe Int
sumABC l = case lookup "A" l of
           Nothing -> Nothing
           Just a -> case lookup "B" l of
                     Nothing -> Nothing
                     Just b -> case lookup "C" l of
                               Nothing -> Nothing
                               Just c -> Just (a+b+c)

 
