data Circuit = Circ Gates Links

data Gates = Seq GateFn Gates | Empty

data GateFn = And | Or | Xor | Not

data Links = Link Int Int Links | Empte
