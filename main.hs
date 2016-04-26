import Expand
import Syntax
import Pretty
import Data.String.Utils


main = putStrLn (prettyAST (expand ((
  (Quantified Forall 
    (Fcall "allInstance" [(Literal (StringValue "Rel$RelSchema"))]) 
    ("s", (RefType "Rel$RelSchema"))
     Undef 
  )))))
