module Enumerate where


import Syntax
import Data.String.Utils
import Data.Map


myEnumerate :: Expression -> Option -> ProveTree

data Option = Each | Any
flip :: Option -> Option
flip Each = Any
flip Any = Each



data ProveTree = Tree Option [Expression] ProveTree | Node Option Expression [Expression] | Err

-- | myEnumerate cross product the possibilities
myEnumerate (Quantified Forall col (id, tp) body) op = case (myEnumerate col Each) of
  Node Each colExpr colExpr_poss -> Tree Each [(Quantified Forall newCol (id, tp) body) | newCol <- colExpr_poss] (myEnumerate body Each)
  Tree Each col_poss tree -> Tree Each [(Quantified Forall newCol (id, tp) body) | newCol <- col_poss] (myEnumerate body Each)
  _ -> Err 

myEnumerate (Quantified Exists col (id, tp) body) op = case (myEnumerate col Any) of
  Node Any colExpr colExpr_poss -> Tree Any [(Quantified Exists newCol (id, tp) body) | newCol <- colExpr_poss] (myEnumerate body Any)
  Tree Any col_poss tree -> Tree Any [(Quantified Exists newCol (id, tp) body) | newCol <- col_poss] (myEnumerate body Any)
  _ -> Err 
  

myEnumerate (Poss expr poss) op = case (myEnumerate expr op) of
  Node real_expr_op real_expr real_expr_poss -> case length real_expr_poss of
    0 -> Node real_expr_op real_expr [As real_expr pos | pos <- poss]  
    otherwise -> Tree real_expr_op [As expr pos | pos <- poss] (myEnumerate expr op)
  Tree real_expr_op real_expr_poss tree -> Tree real_expr_op [As expr pos | pos <- poss] (myEnumerate expr op)
  otherwise -> Err
  
  
myEnumerate (Navigation field obj (RefType tp)) op = case (myEnumerate obj op) of
  Node real_obj_op real_obj real_obj_poss -> case length real_obj_poss of
    0 -> Node real_obj_op (Navigation field real_obj (RefType tp)) []
    otherwise -> Node real_obj_op (Navigation field real_obj (RefType tp)) [(Navigation field real_obj_pos (RefType tp)) | real_obj_pos <- real_obj_poss]
  Tree real_obj_op real_obj_poss tree -> Tree real_obj_op [(Navigation field real_obj_pos (RefType tp)) | real_obj_pos <- real_obj_poss] (myEnumerate obj op)
  otherwise -> Err

myEnumerate (UnaryExpression uop expr) op = case (myEnumerate expr op) of
  Node real_expr_op real_expr real_expr_poss -> case length real_expr_poss of
    0 -> Node (flip real_expr_op) (UnaryExpression uop real_expr) []
    otherwise -> Node (flip real_expr_op) (UnaryExpression uop real_expr) [(UnaryExpression uop real_expr_pos) | real_expr_pos <- real_expr_poss]
  Tree real_expr_op real_expr_poss tree -> Tree (flip real_expr_op) [(UnaryExpression uop real_expr_pos) | real_expr_pos <- real_expr_poss] (myEnumerate expr op)
  otherwise -> Err

myEnumerate (BinaryExpression bop lhs rhs) op = case (myEnumerate lhs op) of
  Node lhs_op real_lhs real_lhs_poss -> Tree lhs_op [(BinaryExpression bop lhs_pos rhs) | lhs_pos <- real_lhs_poss] (myEnumerate rhs op)
  Tree lhs_op real_lhs_poss tree -> Tree lhs_op [(BinaryExpression bop lhs_pos rhs) | lhs_pos <- real_lhs_poss] (myEnumerate rhs op)
  _ -> Err 

-- | myEnumerate return expr as it is, but wrap with Node constructor.
myEnumerate (Literal (IntValue i)) op = Node op (Literal (IntValue i)) []
myEnumerate (Literal (BoolValue b)) op = Node op (Literal (BoolValue b)) []
myEnumerate (Literal (StringValue s)) op = Node op (Literal (StringValue s)) []

myEnumerate (Variable (id, tp)) op = Node op (Variable (id, tp)) [] 

myEnumerate (Navigation field obj IntType) op =  Node op (Navigation field obj IntType) []
myEnumerate (Navigation field obj BoolType) op =  Node op (Navigation field obj BoolType) []
myEnumerate (Navigation field obj StringType) op = Node op (Navigation field obj StringType) []






myEnumerate _ _ = Err

