module Syntax where



-- * Ocl decompose specific 

-- | Rules
type Rule = String



-- * Ocl specific

-- | Identifier
type Id = String

-- | Name declaration (identifier, type)
type IdType = (Id, Type)

-- | Reference (gives identity to things)
type Ref = Int

{- Types -}

-- | Types 
data Type = 
  BoolType |                                -- ^ bool 
  IntType |                                 -- ^ int
  StringType |                              -- ^ string
  RefType Id                                -- ^ ref to a type Id


{- Expressions -}  
-- | Unary operators
data UnOp = Not

-- | Binary operators  
data BinOp = Plus | Minus | Times | Div | Mod | And | Or | Implies | Equiv | Eq | Neq | Lt | Leq | Gt | Geq

-- | Iterators
data ItOp = Forall | Exists 

-- | Values   
data Value = 
  IntValue Integer |             -- ^ Integer value
  BoolValue Bool |               -- ^ Boolean value
  StringValue String             -- ^ String value


  
-- | Expression
data Expression = 
  Undef |
  Debug String |
  Literal Value |
  Variable IdType |
  Fcall Id [Expression] |                         -- ^ Fcall: FId(args)
  Navigation Id Expression Type|                  -- ^ Navigation: Expression.id
  IfExpr Expression Expression Expression |       -- ^ If: If cond thn els
  UnaryExpression UnOp Expression |
  BinaryExpression BinOp Expression Expression |
  Quantified ItOp Expression IdType Expression |   -- ^ Qop(col, bv, body)
  GenBy Expression Rule |
  Poss Expression [String] 


 
getRule :: Expression -> Rule
getRule (GenBy _ rule) = rule
getRule _ = ""


getExpr :: Expression -> Expression
getExpr (GenBy expr _) = expr
getExpr _ = Undef

isGenBy :: Expression -> Bool
isGenBy (GenBy _ _) = True
isGenBy _ = False

