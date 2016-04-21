plus :: Int -> Int -> Int
plus = (+)

plusPlus :: Int -> Int -> Int -> Int
plusPlus a b c = a + b + c

main = do
  let res = plus 1 2
  putStrLn $ "1+2 = " ++ show res