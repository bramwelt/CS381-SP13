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
type D = Maybe Stack -> Maybe Stack

type Rank = Int
type CmdRank = (Int, Int)


-- Semantics of individual Commands
semCmd :: Cmd -> D
semCmd (LD a) (Just xs)         = Just ([a] ++ xs)
semCmd (ADD)  (Just (x1:x2:xs)) = Just ([x1+x2] ++ xs)
semCmd (MULT) (Just (x1:x2:xs)) = Just ([x1*x2] ++ xs)
semCmd (DUP)  (Just (x1:xs))    = Just ([x1,x1] ++ xs)
semCmd _      _                 = Nothing

-- Semantics of a Program
sem :: Prog -> D
sem [] a = a
sem (x:xs) a = sem xs (semCmd x a)

-- Evaluation 'running' a program. Starts with an empty stack.
--
eval :: Prog -> Maybe Stack
eval p = sem p (Just [])

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

p1 = [LD 3, DUP, ADD, LD 5, SWAP] -- Just [6, 5]
p2 = [LD 8, POP 1, LD 3, DUP, POP 2, LD 4] -- Just [4]
p3 = [LD 3, LD 4, LD 5, MULT, ADD] -- Just [23]
p4 = [LD 2, ADD] -- Nothing
p5 = [DUP] -- Nothing
p6 = [POP 1] -- Nothing


{--- Part (b) ---}

-- Follow example in 'example/TypeCheck.hs'
-- First calls 'rankP' to check type correctness, then 'sem' if correct.
{- TODO semStatTC -}

{- TODO Answer the question: 
           What is the new type of the function sem and why can the
           function definition be simplified to have this type?
-}



{----------------------- Exercise 2 -------------------------}



{----------------------- Exercise 3 -------------------------}

