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

   Note: <x,y> denotes <static, dynamic>

   [ ]
1  [x:?]
2  [y:?, x:?]
3  [z:?, y:?, x:?]
4  [z:?, y:?, x:3]
5  [z:?, y:7, x:3]
6  [f:{}, z:?, y:7, x:3]
7  [y:?, f:{}, z:?, y:7, x:3]
8  [y:11, f:{}, z:?, y:7, x:3]
9  [g:{}, y:11, f:{}, z:?, y:7, x:3]
10 [y:?, g:{}, y:11, f:{}, z:?, y:7, x:3]
11 [y:13, g:{}, y:11, f:{}, z:?, y:7, x:3]
12 >>
   9 [x:2, y:13, g:{}, y:11, f:{}, z:?, y:7, x:3]
     >>
     6 [res: <21, 26>, y: <7, 13>, x:2, y:13, g:{}, y:11, f:{}, z:?, y:7, x:3]
     <<
   9 [res: <21, 26>, x:2, y:13, g:{}, y:11, f:{}, z:?, y:7, x:3]
   <<
12 [y:13, g:{}, y:11, f:{}, z:<21, 26>, y:7, x:3]
13 [g:{}, y:11, f:{}, z:<21, 26>, y:7, x:3]
14 [y:11, f:{}, z:<21, 26>, y:7, x:3]
15 [z:<21, 26>, y:7, x:3]
16 [ ]

(a) Which value will be assigned to z in line 12 under static scoping?

    z: 21

(b) Which value will be assigned to z in line 12 under dynamic scoping?

    z: 26

-}

{- Exercise 3: Parameter Passing

Assume dynamic scoping.
What are the values of y and z at the end of the above block under the assumption that both parameters a and x are passed:

0  [ ]
1  [y:?]
2  [z:?, y:?]
3  [z:?, y:7]
4  [f:{}, z:?, y:7]
8  [g:{}, f:{}, z:?, y:7]
13 [g:{}, f:{}, z:?, y:7]
   >>
   8 [x:14, g:{}, f:{}, z:?, y:7]
   9 >>
     4 [a:15, x:14, g:{}, f:{}, z:?, y:7]
     5 [a:15, x:14, g:{}, f:{}, z:?, y:16]
     6 [res:31, a:15, x:14, g:{}, f:{}, z:?, y:16]
     <<
   9 [x:14, g:{}, f:{}, z:?, y:32]
   10 >>
      4 [a:-15, x:14, g:{}, f:{}, z:?, y:32]
      5 [a:-15, x:14, g:{}, f:{}, z:?, y:-14]
      6 [res:-29, a:-15, x:14, g:{}, f:{}, z:?, y:-14]
      <<
   10 [x:14, g:{}, f:{}, z:-29, y:-14]
   11 [res:-28, x:14, g:{}, f:{}, z:-29, y:-14]
   <<
13 [g:{}, f:{}, z:-28, y:-14]
14 [z:-28, y:-14]
15 [ ]

(a) Call-By-Name

(b) Call-By-Need
1 [y:?]
2 [z:?, y:?]
3 [z:?, y:7]
4 [f:{}, z:?, y:7]
8 [g:{}, f:{}, z:?, y:7]
13 [g:{}, f:{}, z:g(14), y:7]
  >>
  8 [x:14, g:{}, f:{}, z:g(14), y:7]
  9 [y:(f(15)+1), x:14, g:{}, f:{}, z:g(14), y:7]
    >>
    4 [a:15, y:(f(15)+1), x:14, g:{}, f:{}, z:g(14), y:7]
    5 [y:16, a:15, y:(f(15)+1), x:14, g:{}, f:{}, z:g(14), y:7]
    6 [y:32, x:14, g:{}, f:{}, z:g(14), y:7]
  10 [z:f(-15), y:32, x:14, g:{}, f:{}, z:g(14), y:7]
    >>
    4 [a:-15, z:f(-15), y:32, x:14, g:{}, f:{}, z:g(14), y:7]
    5 [y:-14, a:-15, z:f(-15), y:32, x:14, g:{}, f:{}, z:g(14), y:7]
    6 [z:-29, y:32, x:14, g:{}, f:{}, z:g(14), y:7]
  11 [g:{}, f:{}, z:-28, y:7]
14 [z:-28, y:7]
15 []
    
-}
