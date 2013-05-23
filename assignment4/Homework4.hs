{- Authors:
     Trevor Bramwell
     Emily  Dunham
     Daniel Reichert
-}

{- Exercise 1: Runtime Stack
   
   Assume static scoping and call-by-value parameter passing.

0  [ ] 
1  [x:?]
2  [y:?, x:?]
3  [y:1, x:?]
4  [f:{}, y:1, x:?]
11 [f:{}, y:1, x:?]
11 >>
   5 [x:2, f:{}, y:1, x:?]
   8 [x:2, f:{}, y:1, x:?]
   4 >>
     5 [x:1, x:2, f:{}, y:1, x:?]
     8 [x:1, x:2, f:{}, y:1, x:?]
     4 >>
       5 [x:0, x:1, x:2, f:{}, y:1, x:?]
       6 [x:0, x:1, x:2, f:{}, y:1, x:?]
       9 [res:1, x:0, x:1, x:2, f:{}, y:1, x:?]
       <<
     8 [x:1, x:2, f:{}, y:2, x:?]
     9 [res:2, x:1, x:2, f:{}, y:2, x:?]
     <<
   8 [x:2, f:{}, y:5, x:?]
   9 [res: 5, x:2, f:{}, y:5, x:?]
   <<
11 [f:{}, y:5, x:5]
12 [y:5, x:5]
13 []

-}

{- Exercise 2: Static and Dynamic Scope

   []
1  [x:?]
2  [y:?, x:?]
3  [z:?, y:?, x:?]
4  [z:?, y:?, x:3]
5  [z:?, y:7, x:3]
6  [f:{}, z:?, y:7, x:3]
15 [z:?, y:7, x:3]
16 [ ]

(a) Which value will be assigned to z in line 12 under static scoping?

    Line 12 is never called.


(b) Which value will be assigned to z in line 12 under dynamic scoping?

    Line 12 is never called.

-}

{- Exercise 3: Parameter Passing
What are the values of y and z at the end of the above block under the assumption that both parameters a and x are passed:
(a) Call-By-Name
(b) Call-By-Need
-}
