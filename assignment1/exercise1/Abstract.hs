data Expr = N Int | Plus Expr Expr | Times Expr Expr | Neg Expr
        deriving Show

data Op = Add | Multiply | Negate
        deriving Show

data Exp = Num Int | Apply Op [Exp]
        deriving Show

--(a)
a = Apply Multiply [Apply Negate [Apply Add [Num 3, Num 4]], Num 7]
--(b) The advantage of Expr is that it requires fewer symbols to achieve the same semantic meaning
-- For example, (7+7)+7 is the same as:
--      Plus (Plus (N 7) (N 7)) (N 7)
--      Apply Add [Apply Add [Num 7, Num 7], Num 7]
-- As I have demonstrated, the Exp syntax is longer in that it requires the repeated use of Apply.  The disadvantage of the Expr syntax is that it requires a parenthises to surround each number.
--(c)
translate :: Expr -> Exp
translate (N a) = (Num a)
--translate (Plus a b) = (Apply Add [a])
--translate Times xs = Apply Multiply xs
--translate Neg xs = Apply Negate xs
