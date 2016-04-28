module Test where


import Data.Map

data MyList = Or [String] | And [String] | Err

append :: MyList -> String -> MyList
append (Or l) s = Or (l++[s])
append (And l) s = And (l++[s])

cross :: MyList -> MyList -> MyList

cross (And a) (Or b) = And