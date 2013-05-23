{- Authors:
     Trevor Bramwell
     Emily  Dunham
     Daniel Reichert
-}

{-

To make the debugging and reading of runtime stack traces easier, I
suggest that you use indentation to indicate function calls and returns.
E.g. in exercise 1, you would probably start out as follows:

>    []
> 2  [y=?, x=?]
> 3  [y=1, x=?]
> 4  [f={}, y=1, x=?]

Now the next line that gets executed is line 11. But in that line f is
called, which leads to the exception of line 5. So we could indicate
this in the following way (substituting the correct value for …).

> 11 >>
>    5  [x=…, f={}, y=1, x=?]

Now, depending on the evaluation of the conditional, we will have to
execute either line 6 or 8. Let's assume it is line 8. In that case we
encounter another call to f, which we would lead to a further
indentation.

>    8  >>
>       5  [x=…, x=…, f={}, y=1, x=?]

At some point the function call will (hopefully) terminate and return
with a value, which we can the write as follows.

>       <<
>    8  [x=…, f={}, y=…, x=…]

This brings us back one level. When we return from a function call, we
can also briefly record the result in the runtime stack before we remove
the activation record. Here is an example that illustrates how to
reflect a return statement in the runtime stack.

>    9  [res=…, x=…, f={}, y=…, x=…]
>    <<
> 11 [f={}, y=…, x=…]

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
     [x:2, f:{}, y:1, x:?]
   8 [x:2, f:{}, y:1, x:?]
   4 >>
       [x:1, x:2, f:{}, y:1, x:?]
     8 [x:1, x:2, f:{}, y:1, x:?]
     4 >>
         [x:0, x:1, x:2, f:{}, y:1, x:?]
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
