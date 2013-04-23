-- Digital Circuit Design Language
--
module DCDL where

import Prelude hiding (Num)

type Num = Int
data Nums = Ns Num Num

data Circ = C [Gates] [Links]

data Gates = Con Num GateFn [Gates]
           
data Links = FromTo Nums Nums [Links]

data GateFn = And
            | Or
            | Xor
            | Not

prog = C [Con 1 Xor, Con 2 And] [FromTo 1.1 2.1, FromTo 1.2 2.2]

-- 1:xor;
-- 2:and;
-- from 1.1 to 2.1;
-- from 1.2 to 2.2;

