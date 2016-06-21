module EnumerateList where


import Syntax
import Data.String.Utils
import Data.Map


myEnumerate :: Expression -> [Expression]




-- | myEnumerate cross product the possibilities
myEnumerate (Quantified Forall col (id, tp) body) = [(Quantified Forall (getExpr newCol) (id, tp) (BinaryExpression Implies (GenBy (Variable (id,tp)) (getRule newCol)) (newBody))) | newCol <- myEnumerate col, newBody <- myEnumerate body, isGenBy newCol]


myEnumerate (Quantified Exists col (id, tp) body) = [(Quantified Exists (getExpr newCol) (id, tp) (BinaryExpression Implies (GenBy (Variable (id,tp)) (getRule newCol)) (newBody))) | newCol <- myEnumerate col, newBody <- myEnumerate body, isGenBy newCol]
  
myEnumerate (Poss expr poss) = [GenBy newExpr pos | newExpr <- myEnumerate expr, pos <- poss]

myEnumerate (Navigation field obj (RefType tp)) = [(Navigation field real_obj_pos (RefType tp)) | real_obj_pos <- (myEnumerate obj)]
myEnumerate (Navigation field obj IntType) = [(Navigation field real_obj_pos IntType) | real_obj_pos <- (myEnumerate obj)]
myEnumerate (Navigation field obj BoolType) = [(Navigation field real_obj_pos BoolType) | real_obj_pos <- (myEnumerate obj)]
myEnumerate (Navigation field obj StringType) = [(Navigation field real_obj_pos StringType) | real_obj_pos <- (myEnumerate obj)]

myEnumerate (UnaryExpression uop expr) = [(UnaryExpression uop real_expr_pos) | real_expr_pos <- (myEnumerate expr)]

myEnumerate (BinaryExpression bop lhs rhs) = [(BinaryExpression bop lhs_pos rhs_pos) | lhs_pos <- (myEnumerate lhs), rhs_pos <- (myEnumerate rhs)]


myEnumerate (Fcall "allInstance" exprs)  =  case length exprs of
  1 -> [(Fcall "allInstance" [real_expr_pos]) | real_expr_pos <- myEnumerate (head exprs)]
  otherwise -> [Undef]
  
  
  
-- | myEnumerate return expr as it is, but wrap with Node constructor.
myEnumerate (Literal (IntValue i))  = [(Literal (IntValue i))]
myEnumerate (Literal (BoolValue b))  = [(Literal (BoolValue b))]
myEnumerate (Literal (StringValue s))  = [(Literal (StringValue s))]

myEnumerate (Variable (id, tp))  = [(Variable (id, tp))]


myEnumerate _ = [Undef]




