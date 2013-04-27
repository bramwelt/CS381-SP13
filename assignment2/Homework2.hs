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
data Mode = Up | Down

type State = (Mode,Int,Int)
type Line = (Int,Int,Int,Int)
type Lines = [Line]

-- TODO: 
-- semS :: Cmd3 -> State -> (State,Lines)
-- sem' :: Cmd3 -> Lines
