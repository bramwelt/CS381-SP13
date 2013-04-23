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

-- Position
--
data Pos = M Num | N Name

-- Parameters
--
type Pars = [Name]

-- Values
--
type Vals = [Num]


-- Terminal Symbol types
--
type Num = Int
type Name = String


-- Show implementations
--
instance Show Mode where
    show Up   = "up"
    show Down = "down"

instance Show Pos where
    show (M a) = show a
    show (N b) = b

-- Vector macro
--
-- Assume the pen is down...
--  def vector (x1, y1, x2, y2)  
--      pen up
--      moveto (x1, y1)
--      pen down
--      moveto (x2, y2)
--      pen up
vector = Def "vector"
             ["x1","y1","x2","y2"]
             (Seq [Pen Up,
                   MoveTo (N "x1") (N "y1"),
                   Pen Down,
                   MoveTo (N "x2") (N "y2"),
                   Pen Up])

steps :: Int -> Cmd
steps a | a <= 1  = Seq [Call "vector" [0, 0, 0, 1],
                         Call "vector" [0, 1, 1, 1]]
steps a           = Seq [steps (a-1),
                         Seq [Call "vector" [a-1, a-1, a-1, a],
                              Call "vector" [a-1, a, a, a]]]

--
-- Attemps at simplifying steps
--
--t = (Seq [Seq [Pen Up]])
--t2 = (Seq [t])
--t3 = (Seq [Seq [Seq [Pen Down]]])
--
--simp :: Cmd -> Cmd
--simp (Seq [Seq a]) = simp (Seq a)
--simp a       = a
--
----b = Seq [Call "vector", Call "vector" .. ]
--
---- cv1 0 = 0, 0, 0, 1
----
--cv1 :: Int -> Cmd
--cv1 a = Call "vector" [a, a, a, a+1]
--
---- cv2 1 = 0, 1, 1, 1
--cv2 :: Int -> Cmd
--cv2 a = Call "vector" [a-1, a, a, a]
--
---- Steps constructs a ML program that draws a stair of n steps
----
--steps :: Int -> Cmd
--steps a = Seq z
--        where z
--              a <= 1    = [cv1 (a-1), cv2 a]
--              otherwise = [steps (a-1), cv1 (a-1), cv2 a]

--a = steps 3
