module Homework2 where

{----------------------- Exercise 1 -------------------------}

type Prog = [Cmd]

data Cmd = LD Int
         | ADD
         | MULT
         | DUP
         deriving Show

type Stack = [Int]
-- Do we instantiate a stack and work on it? should D be a Maybe Stack?? We'll
-- need both a stack and a program in order to run the commands and turn
-- anything into ints.


-- TODO
type D = Stack -> Stack
-- sem :: Prog -> D
-- semCmd :: Cmd -> D

--semCmd :: Cmd -> Stack -> Stack
semCmd :: Cmd -> D
semCmd (LD a) = \xs         -> [a] ++ xs
semCmd (ADD)  = \(x1:x2:xs) -> [x1+x2] ++ xs
semCmd (MULT) = \(x1:x2:xs) -> [x1*x2] ++ xs
semCmd (DUP)  = \(x1:xs)    -> [x1,x1] ++ xs

--sem :: Prog -> Stack -> Stack
sem :: Prog -> D
sem [] a = a
sem (x:xs) a = sem xs (semCmd x a)

eval :: Prog -> Stack
eval p = sem p []

--Test data
test1 = [LD 3, DUP, ADD, DUP, MULT] -- [3] -> [3,3] -> [6] -> [6,6] -> [36]
test2 = [LD 3, ADD] -- Error
test3 = [] -- []
test4 = [LD 2, DUP, MULT] -- [2] -> [2, 2] -> [4]

{----------------------- Exercise 2 -------------------------}





{----------------------- Exercise 3 -------------------------}

data Cmd3 = Pen Mode
          | MoveTo Int Int
          | Seq Cmd3 Cmd3
          deriving Show

data Mode = Up | Down
          deriving (Show, Eq)

type State = (Mode,Int,Int)
type Line = (Int,Int,Int,Int)
type Lines = [Line]

semS :: Cmd3 -> State -> (State,Lines)
-- Change state if pen was up and now down, or vise versa.
--  Otherwise keep state, produce no lines.
semS (Pen m1)       s@(m2, x, y) | m1 /= m2             = ((m1, x, y), [])
                                 | otherwise            = (s, [])
-- If moving to new position and pen is Down, a line is created,
--  Otherwise keep state, and produce no lines.
semS (MoveTo x1 y1) (m, x2, y2)  | m == Up              = (ns, [])
                                 | x1 /= x2 && y1 /= y2 = (ns, [(x2, y2, x1, y1)])
                                 | otherwise            = (ns, [])
                                 where ns = (m, x1, y1)
semS (Seq a b) s = (fst s2, snd s1 ++ snd s2)
                 where 
                    s1 = semS a s
                    s2 = semS b (fst s1)

-- lsem1 = semS (Pen Down) (Up, 0, 0) -- ((Down, 0, 0) [])
-- lsem2 = semS (Pen Up) (Down, 0, 0) -- ((Down, 0, 0) [])
-- lsem3 = semS (MoveTo 2 3) (Up, 0, 0) -- ((Up, 2, 3), [])
-- lsem4 = semS (MoveTo 2 3) (Down, 1, 1) -- ((Down, 2, 3), [(1, 1, 2, 3)])
-- lsem5 = semS ((MoveTo 1 1) `Seq` (MoveTo 2 2)) (Up, 0, 0) -- ((Up 2, 2), [])

-- Initial State
sinit = (Up, 0, 0)

sem' :: Cmd3 -> Lines
-- Keeps track of lines created
sem' a = snd (semS a sinit)

ltest1 = Pen Down `Seq` MoveTo 1 1
ftest1 = sem' ltest1 -- [(0, 0, 1, 1)]
ltest2 = Pen Down `Seq` MoveTo 1 1 `Seq` MoveTo 3 5
ftest2 = sem' ltest2 -- [(0, 0, 1, 1), (1, 1, 3, 5)]
