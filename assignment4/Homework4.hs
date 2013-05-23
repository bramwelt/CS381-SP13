{- Authors:
     Trevor Bramwell
     Emily  Dunham
     Daniel Reichert
-}

{- Exercise 1: Runtime Stack

[ ] push
[x:?] push
[y:?, x:?] push
[y:1, x:?] push
[f={}, y:1, x:?] push
[x:2, f={}, y:1, x:?] push
[x:1, f={}, x:2, f={}, y:1, x:?] push
[x:0, f={}, x:1, f={}, x:2, f={}, y:1, x:?] push
[y:1, x:0, f={}, x:1, f={}, x:2, f={}, y:1, x:?]  push
[y:2, x:1, f={}, x:2, f={}, y:1, x:?]  pop x3
[y:4, x:2, f={}, y:1, x:?]  pop x3
[y:8, y:1, x:?] pop x3
[y:1, x:8] pop
[x:8] pop
[ ]

-}

{- Exercise 2: Static and Dynamic Scope
(a) Which value will be assigned to z in line 12 under static scoping?
(b) Which value will be assigned to z in line 12 under dynamic scoping?
-}
{- Exercise 3: Parameter Passing
What are the values of y and z at the end of the above block under the assumption that both parameters a and x are passed:
(a) Call-By-Name
(b) Call-By-Need
-}
