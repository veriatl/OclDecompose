module Pretty where

import Syntax
import Data.String.Utils

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

prettyAST Undef = "Undef"
prettyAST (Literal (IntValue i)) = "(" ++ "Literal" ++  show i ++ ")"
prettyAST (Literal (BoolValue b)) = "(" ++ "Literal" ++  show b ++ ")"
prettyAST (Literal (StringValue s)) = "(" ++ "Literal" ++  show s ++ ")"

prettyAST (Variable (id, tp)) = "(" ++ "Variable" ++ show id ++ (prettyType tp) ++")"

prettyAST (IfExpr cond thn els) = "IfExpr" ++ (prettyAST cond) ++ (prettyAST thn) ++ (prettyAST els)
prettyAST (UnaryExpression uop expr) = "UnaryExpression" ++ "Not" ++ (prettyAST expr)
prettyAST (BinaryExpression bop lhs rhs) = "BinaryExpression" ++ (prettyOperator bop) ++ (prettyAST lhs) ++ (prettyAST rhs)

prettyAST (Quantified Forall col (id, tp) body) = "Forall" ++ (prettyAST col) ++ "(" ++ "Variable" ++ show id ++ (prettyType tp) ++")" ++ (prettyAST body)
prettyAST (Quantified Exists col (id, tp) body) = "Exists" ++ (prettyAST col) ++ "(" ++ "Variable" ++ show id ++ (prettyType tp) ++")" ++ (prettyAST body)

prettyAST (Navigation call src tp) = "Navigation " ++ call ++ " (" ++ (prettyAST src) ++ (prettyType tp) ++")"

prettyAST (UnionSelect expr poss) = "UnionSelect " ++ " (" ++ (prettyAST expr) ++ (join "|" poss) ++")"
prettyAST (Ite expr poss) = "Ite " ++ " (" ++ (prettyAST expr) ++ (join "|" poss) ++")"



prettyAST (Debug str) = "Debug info:" ++ str



prettyAST _ = "Default"