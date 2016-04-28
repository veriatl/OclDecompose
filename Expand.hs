module Expand where

import Syntax
import Data.String.Utils

trace = [("Rel$Relation",["E2R", "R2R"]), ("Rel$RelSchema",["S2S"]), ("Rel$RelAttribute", ["EA2A", "RA2A", "RA2AK"])]
  
expand :: Expression -> Expression

expand (Literal (IntValue i)) = Literal (IntValue i)
expand (Literal (BoolValue b)) = Literal (BoolValue b)
expand (Literal (StringValue s)) = Literal (StringValue s)

expand (Variable (id, tp)) = (Variable (id, tp))

expand (IfExpr cond thn els) = IfExpr (expand cond) (expand thn) (expand els)
expand (UnaryExpression uop expr) = UnaryExpression uop (expand expr)
expand (BinaryExpression bop lhs rhs) = BinaryExpression bop (expand lhs) (expand rhs)

expand (Quantified qop col (id, tp) body) = Quantified qop (expand col) (id, tp) (expand body)

expand (Navigation op src IntType) =  Navigation op src IntType
expand (Navigation op src BoolType) =  Navigation op src BoolType
expand (Navigation op src StringType) =  Navigation op src StringType


expand (Navigation op src (RefType tp)) = case (lookup tp trace) of
    Nothing -> Navigation op (expand src) (RefType tp)
    Just poss -> Poss (Navigation op (expand src) (RefType tp)) poss


  
expand (Fcall fname args) = case fname of
  "allInstance" -> case args of 
    [] -> Undef  
    (x:_) -> case x of
      Literal (StringValue s) -> case lookup s trace of 
        Nothing -> Fcall fname args
        Just poss -> Poss (Fcall fname args) poss
      otherwise -> Fcall fname [(expand x)] 
  otherwise ->  Fcall fname (map expand args)





expand _ = Undef