module Pretty where

import Syntax
import Data.String.Utils
import Text.Format

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




prettyAST :: Expression -> String

prettyAST Undef = "Undef "

prettyAST (Literal (IntValue i)) = format "({0})" [show i]
prettyAST (Literal (BoolValue b)) =  format "({0})" [show b]
prettyAST (Literal (StringValue s)) =  format "({0})" [show s]

prettyAST (Variable (id, tp)) = format "({0})" [(show id)] -- ^ Decide not to print the type for clarity

prettyAST (IfExpr cond thn els) = format "(if({0}) ({1}) else ({2}))" [(prettyAST cond), (prettyAST thn), (prettyAST els)]

prettyAST (UnaryExpression uop expr) = format "(not {0})" [(prettyAST expr)]

prettyAST (BinaryExpression bop lhs rhs) = format "({1} {0} {2})" [(prettyOperator bop), (prettyAST lhs), (prettyAST rhs)]

prettyAST (Quantified Forall col (id, tp) body) = format "(({0})->forAll\n({1}:{2} | {3}))" [(prettyAST col), (show id), (prettyType tp), (prettyAST body)]

prettyAST (Quantified Exists col (id, tp) body) = format "(({0})->exists({1}:{2} | {3}))" [(prettyAST col), (show id), (prettyType tp), (prettyAST body)]

prettyAST (Navigation id src tp) = format "({0}.{1})" [(prettyAST src), (id)]

prettyAST (Poss expr poss) = format "(Poss(({0}), [{1}]))" [(prettyAST expr), (join " | " poss)]

prettyAST (Debug str) = format "*-- {0}*" [str]

prettyAST (Fcall "allInstance" exprs) =  case length exprs of
  1 -> format "{0}.allInstance()" [(join " | " (map prettyAST exprs))]
  otherwise -> "illFormed.allInstance()"
  
prettyAST (GenBy expr rule) = format "(GenBy({0}, {1}))" [(prettyAST expr), rule]
  

prettyAST _ = "Default"