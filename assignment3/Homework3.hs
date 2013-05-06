{- Authors:
     Trevor Bramwell
     Emily  Dunham
     Daniel Reichert
-}

module Homework3 where

{----------------------- Exercise 1 -------------------------}

type Prog = [Cmd]

data Cmd = LD Int
         | ADD
         | MULT
         | DUP
         -- Increment the topmost element of the stack.
         | INC
         -- Exchange the two topmost elements on the stack.
         | SWAP
         -- Pops k elements off the top of the stack.
         | POP Int
         deriving Show

type Stack = [Int]
type D = Stack -> Stack

type Rank = Int
type CmdRank = (Int, Int)


-- Semantics of individual Commands
semCmd :: Cmd -> D
semCmd (LD a)  xs         = [a] ++ xs
semCmd (ADD)   (x1:x2:xs) = [x1+x2] ++ xs
semCmd (MULT)  (x1:x2:xs) = [x1*x2] ++ xs
semCmd (DUP)   (x1:xs)    = [x1,x1] ++ xs
semCmd (INC)   (x1:xs)    = [succ x1] ++ xs
semCmd (SWAP)  (x1:x2:xs) = (x2:x1:xs)
semCmd (POP n) xs         = drop n xs
semCmd _       _          = []

-- Semantics of a Program
sem :: Prog -> D
sem [] a = a
sem (x:xs) a = sem xs (semCmd x a)

-- Map each stack to its rank
-- (n, m) n the number of elements removed from the stack
--        m the number of elements added to the stack
--
rankC :: Cmd -> CmdRank
rankC (LD _)  = (0, 1)
rankC ADD     = (2, 1)
rankC MULT    = (2, 1)
rankC DUP     = (1, 2)
rankC INC     = (1, 1)
rankC SWAP    = (2, 2)
rankC (POP a) = (a, 0)

-- Compute the rank of a program. Nothing represents Errors.
-- defined in terms of 'rank'
--
rankP :: Prog -> Maybe Rank
rankP xs = rank xs 0

-- Given a program and its rank, compute the rank outcome
--
rank :: Prog -> Rank -> Maybe Rank
rank []     r | r >= 0     = Just r
rank (x:xs) r | under >= 0 = rank xs (under+adds)
              where (subs, adds) = rankC x
                    under        = r - subs
rank _      _ = Nothing

{--- Part (b) ---}

data Type = A Stack | TypeError deriving Show

-- Follow example in 'example/TypeCheck.hs'
-- First calls 'rankP' to check type correctness, then 'sem' if correct.
typeSafe :: Prog -> Bool
typeSafe p = (rankP p) /= Nothing

semStatTC :: Prog -> Type
semStatTC p | typeSafe p = A (sem p [])
            | otherwise  = TypeError

{- TODO Answer the question: 
           What is the new type of the function sem and why can the
           function definition be simplified to have this type?
-}

p1 = [LD 3, DUP, ADD, LD 5, SWAP] -- Just [6, 5]
p2 = [LD 8, POP 1, LD 3, DUP, POP 2, LD 4] -- Just [4]
p3 = [LD 3, LD 4, LD 5, MULT, ADD] -- Just [23]
p4 = [LD 2, ADD] -- Nothing
p5 = [DUP] -- Nothing
p6 = [POP 1] -- Nothing


{----------------------- Exercise 2 -------------------------}



{----------------------- Exercise 3 -------------------------}

