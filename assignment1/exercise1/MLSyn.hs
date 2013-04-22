-- MiniLogo Grammar Module
--
module MLSyn where

import Prelude hiding (Num)

-- MiniLogo Grammer
--
data Cmd = Pen Mode
         | MoveTo Pos Pos
         | Def Name Pars Cmd
         | Call Name Vals
         | Seq [Cmd]
         deriving Show

-- Mode
--
data Mode = Up | Down
            deriving Show

-- Position
--
data Pos = M Num | N Name
           deriving Show

-- Parameters
--
data Pars = Pars [Name]
            deriving Show
--data Pars = MPars Name Pars | NPars Name

-- Values
--
data Vals = Vals [Num]
            deriving Show
--data Vals = MVals Num Vals | NVals Num


-- Terminal Symbol types
--
type Num = Int
type Name = String

-- Vector macro
--
-- Assume the pen is down...
--  def vector (x1, y1, x2, y2)  
--      pen up
--      moveto (x1, y1)
--      pen down
--      moveto (x2, y2)
--      pen up
vector = (Def "vector" 
              (Pars ["x1","y1","x2","y2"]) 
              (Seq [Pen Up, 
                    MoveTo (N "x1") (N "y1"),
                    Pen Down,
                    MoveTo (N "x2") (N "y2"),
                    Pen Up]))
