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

p1 = [LD 3, DUP, ADD, LD 5, SWAP] -- Just [6, 5]
p2 = [LD 8, POP 1, LD 3, DUP, POP 2, LD 4] -- Just [4]
p3 = [LD 3, LD 4, LD 5, MULT, ADD] -- Just [23]
p4 = [LD 2, ADD] -- Nothing
p5 = [DUP] -- Nothing
p6 = [POP 1] -- Nothing

{-
Rank (n, m) 
  - n is the number of elements the operation takes from the stack.
  - m is the number of elements the operation puts on the stack.

  The rank for a program is defined as the rank that would be obtained
  if the program were run on an empty stack.

  A rank error indicates stack underflow
-}

type Rank = Int
type CmdRank = (Int, Int)

-- Map each stack to its rank
rankC :: Cmd -> CmdRank
rankC (LD a)  = (0, 1)
rankC ADD     = (2, 1)
rankC MULT    = (2, 1)
rankC DUP     = (1, 1)
rankC INC     = (1, 1)
rankC SWAP    = (2, 2)
rankC (POP i) = (1, 0)

-- Compute the rank of a program. Nothing represents Errors.
-- defined in terms of 'rank'
{- TODO rankP :: Prog -> Maybe Rank -}


-- Given a program and its rank, compute the rank outcome
{- TODO rank :: Prog -> Rank -> Maybe Rank -}


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

