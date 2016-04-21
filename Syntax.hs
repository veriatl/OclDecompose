module Language.Ocl.AST where

-- | Identifier
type Id = String

-- | Name declaration (identifier, type)
type IdType = (Id, Type)

-- | Reference (gives identity to things)
type Ref = Int

{- Types -}

-- | Types parametrized by the representation of free type variables
data GenType fv = 
  BoolType |                                -- ^ bool 
  IntType |                                 -- ^ int
  MapType [fv] [GenType fv] (GenType fv) |  -- 'MapType' @type_vars domains range@ : arrow type (used for maps, function and procedure signatures)
  IdType Id [GenType fv]                    -- 'IdType' @name args@: type denoted by an identifier (either type constructor, possibly with arguments, or a type variable)

  
-- | Regular types with free variables represented as identifiers 
type Type = GenType Id


{- Expressions -}  
-- | Unary operators
data UnOp = Not

-- | Binary operators  
data BinOp = Plus | Minus | Times | Div | Mod | And | Or | Implies | Explies | Equiv | Eq | Neq | Lt | Leq | Gt | Geq

-- | Iterators
data ItOp = Forall | Exists 

-- | Values   
data Value = IntValue Integer |  -- ^ Integer value
  BoolValue Bool |               -- ^ Boolean value
  StringValue String |           -- ^ String value
  CustomValue Type Ref |         -- ^ Value of a user-defined type
  Reference Type Ref             -- ^ Map reference

  
-- | Expression
data Expression = 
  Literal Value |
  Fcall Id [Expression] |                         -- ^ Fcall(FId, args)
  IfExpr Expression Expression Expression |       -- ^ If(cond, thn, els)
  UnaryExpression UnOp Expression |
  BinaryExpression BinOp Expression Expression |
  Quantified ItOp Expression IdType Expression    -- ^ Qop(col, bv, body)


main = undefined