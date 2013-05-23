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

0  [ ] 
1  [x:?] push
2  [y:?, x:?] push
3  [y:1, x:?] push
4  [f={}, y:1, x:?] push
11 [f={}, y:1, x:?] push
11 >>
   4 [x:2, f={}, y:1, x:?] push
   8 [f={}, x:2, f={}, y:1, x:?] push
   4 >>
       4 [x:1, f={}, x:2, f={}, y:1, x:?] push
       8 [f={}, x:1, f={}, x:2, f={}, y:1, x:?] push
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
