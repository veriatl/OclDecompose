module Enumerate where


import Syntax
import Data.String.Utils
import Data.Map


myEnumerate :: Expression -> Option -> ProveTree

data Option = Each | Any

data ProveTree = Tree Option [Expression] ProveTree | Node Option Expression [Expression] | Err


myEnumerate (Quantified Forall col (id, tp) body) Each = case (myEnumerate col Each) of
  Node op colExpr colExpr_poss -> Tree Each [(Quantified Forall newCol (id, tp) body) | newCol <- colExpr_poss] (myEnumerate body Each)
  Tree op col_poss tree -> Tree Each [(Quantified Forall newCol (id, tp) body) | newCol <- col_poss] (myEnumerate body Each)
  _ -> Err 

myEnumerate (Quantified Exists col (id, tp) body) Any = case (myEnumerate col Any) of
  Node op colExpr colExpr_poss -> Tree Any [(Quantified Exists newCol (id, tp) body) | newCol <- colExpr_poss] (myEnumerate body Any)
  Tree op col_poss tree -> Tree Any [(Quantified Exists newCol (id, tp) body) | newCol <- col_poss] (myEnumerate body Any)
  _ -> Err 
  

myEnumerate (Poss expr poss) op = case (myEnumerate expr op) of
  Node op real_expr real_expr_poss -> case length real_expr_poss of
    0 -> Node op real_expr [As real_expr pos | pos <- poss]
    otherwise -> Tree op [As expr pos | pos <- poss] (myEnumerate expr op)
  Tree op real_expr_poss tree -> Tree op [As expr pos | pos <- poss] (myEnumerate expr op)
  otherwise -> Err
  
  
myEnumerate (Navigation field obj (RefType tp)) op = case (myEnumerate obj op) of
  Node op real_obj real_obj_poss -> case length real_obj_poss of
    0 -> Node op (Navigation field real_obj (RefType tp)) []
    otherwise -> Node op (Navigation field real_obj (RefType tp)) [(Navigation field real_obj_pos (RefType tp)) | real_obj_pos <- real_obj_poss]
  Tree op real_obj_poss tree -> Tree op [(Navigation field real_obj_pos (RefType tp)) | real_obj_pos <- real_obj_poss] (myEnumerate obj op)
  otherwise -> Err

myEnumerate (UnaryExpression uop expr) op = case (myEnumerate expr op) of



-- myEnumerate (BinaryExpression bop lhs rhs) = BinaryExpression bop (expand lhs) (expand rhs)



myEnumerate (Literal (IntValue i)) op = Node op (Literal (IntValue i)) []
myEnumerate (Literal (BoolValue b)) op = Node op (Literal (BoolValue b)) []
myEnumerate (Literal (StringValue s)) op = Node op (Literal (StringValue s)) []

myEnumerate (Variable (id, tp)) op = Node op (Variable (id, tp)) [] 

myEnumerate (Navigation field obj IntType) op =  Node op (Navigation field obj IntType) []
myEnumerate (Navigation field obj BoolType) op =  Node op (Navigation field obj BoolType) []
myEnumerate (Navigation field obj StringType) op = Node op (Navigation field obj StringType) []






myEnumerate _ _ = Err

