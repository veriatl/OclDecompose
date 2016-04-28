import Expand
import Enumerate
import Syntax
import Pretty
import Data.String.Utils


main = putStrLn (prettyAST myEnumerate (expand ((
  (Quantified Forall 
    (Fcall "allInstance" [(Literal (StringValue "Rel$RelSchema"))]) 
    ("s", (RefType "Rel$RelSchema"))
     Undef 
  )))))
