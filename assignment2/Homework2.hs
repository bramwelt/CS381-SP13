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
semS (MoveTo x1 y1) s@(m, x2, y2) | m == Up             = (ns, [])
                                 | x1 /= x2 && y1 /= y2 = (s, [])
                                 | otherwise            = (ns, [(x1, y1, x2, y2)])
                                 where ns = (m, x1, x2)
semS (Seq a b) s = semS b (fst (semS a s))


-- Initial State
sinit = (Up, 0, 0)

sem' :: Cmd3 -> Lines
-- Keeps track of lines created
sem' (Seq a b) = snd (s1) ++ snd (semS b (fst s1))
               where s1 = semS a sinit
-- Otherwise just get lines produced
sem' a = snd (semS a sinit)

ltest1 = Seq (Pen Down) (MoveTo 1 1) -- [(0, 0, 1, 1)]
ltest2 = Seq (Pen Down) (
             Seq (MoveTo 1 1) (MoveTo 3 5)) -- [(0, 0, 1, 1), (1, 1, 3, 5)]
