module PrintProveTree where

import Syntax
import Data.String.Utils
import Text.Format
import Enumerate


printLv :: Int -> String
printLv n = replicate (n*4) ' '

printOp :: Option -> String
printOp Each = "(E)"
printOp Any = "(A)"

printTree :: ProveTree -> Int -> String

printTree (Tree op exprs subTree) lv = case (length (printTree subTree (lv+1))) - (length ("\n" ++ (printLv (lv+1)) ++ (printOp op) ++ "\n"++ (printLv (lv+1)))) of
  0 -> ("\n" ++ (printLv lv) ++ (printOp op) ++ "\n" ++ (printLv lv)) ++
       join ("\n"++ (printLv lv)) 
            (map (prettyAST True) exprs)
  _ -> ("\n" ++ (printLv lv) ++ (printOp op) ++ "\n" ++ (printLv lv)) ++
       join ("\n"++ (printLv lv))
            (map (++ (" where _PlaceHolder = " ++ (printTree subTree (lv+1)))) 
                 (map (prettyAST False) exprs))



printTree (Node op expr poss) lv = case length poss of
  0 -> prettyAST False expr
  _ -> "Err"
  
printTree Err lv = "Err"






-- customized printAST, mainly in print [poss] expr


prettyType :: Type -> String
prettyType BoolType = ":Bool"
prettyType IntType = ":Int"
prettyType StringType = ":String"
prettyType (RefType id) = ": "++id

prettyOperator :: BinOp -> String
prettyOperator Plus = "+"
prettyOperator Minus = "-"
prettyOperator Times = "*"
prettyOperator Div = "/"
prettyOperator Mod = "%"
prettyOperator And = "&&"
prettyOperator Or = "&&"
prettyOperator Implies = "==>"
prettyOperator Equiv = "<==>"
prettyOperator Eq = "=="
prettyOperator Neq = "<>"
prettyOperator Lt = "<"
prettyOperator Leq = "<="
prettyOperator Gt = ">"
prettyOperator Geq = ">="




prettyAST :: Bool -> Expression -> String

prettyAST _ Undef = "Undef "

prettyAST _ (Literal (IntValue i)) = format "({0})" [show i]
prettyAST  _ (Literal (BoolValue b)) =  format "({0})" [show b]
prettyAST  _ (Literal (StringValue s)) =  format "({0})" [show s]

prettyAST  _ (Variable (id, tp)) = format "({0})" [(show id)] -- ^ Decide not to print the type for clarity

prettyAST  _ (IfExpr cond thn els) = format "(if({0}) ({1}) else ({2}))" [(prettyAST False cond), (prettyAST False thn), (prettyAST False els)]

prettyAST  _ (UnaryExpression uop expr) = format "(not {0})" [(prettyAST False expr)]

prettyAST  _ (BinaryExpression bop lhs rhs) = format "({1} {0} {2})" [(prettyOperator bop), (prettyAST False lhs), (prettyAST False rhs)]

prettyAST True (Quantified Forall col (id, tp) body)  = format "(({0})->forAll({1}:{2} | {3}))" [(prettyAST False col), (show id), (prettyType tp), (prettyAST False body)]
prettyAST False (Quantified Forall col (id, tp) body)  = format "(({0})->forAll({1}:{2} | _PlaceHolder))" [(prettyAST False col), (show id), (prettyType tp)]

prettyAST True (Quantified Exists col (id, tp) body)  = format "(({0})->exists({1}:{2} | {3}))" [(prettyAST False col), (show id), (prettyType tp), (prettyAST False body)]
prettyAST False (Quantified Exists col (id, tp) body)  = format "(({0})->exists({1}:{2} | _PlaceHolder))" [(prettyAST False col), (show id), (prettyType tp)]

prettyAST  _ (Navigation id src tp) = format "({0}.{1})" [(prettyAST False src), (id)]

prettyAST  _ (Poss expr poss) = format "({0})" [(prettyAST False expr)]

prettyAST  _ (Debug str) = format "*-- {0}*" [str]

prettyAST  _ (Fcall "allInstance" exprs) =  case length exprs of
  1 -> format "{0}.allInstance()" [(join " | " (map (prettyAST False) exprs))]
  otherwise -> "illFormed.allInstance()"
  
prettyAST  _ (GenBy expr rule) = format "({0} GenBy {1})" [(prettyAST  False expr), rule]
  

prettyAST _  _= "Default"