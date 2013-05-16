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
