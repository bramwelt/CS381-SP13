-- MiniLogo language Pretty Printer Module
--
module MLPP where

import MLSyn


pp :: Cmd -> String
pp (Pen a)        = "pen "++show a
pp (MoveTo a b)   = "moveto ("++show a++","++show b++")"
pp (Def n p c)    = "def "++n++" ("++show p++")\n"++pp c
pp (Call n v)     = "call "++n++" ("++show v++")"
pp (Seq [])       = ""
pp (Seq (a:as))   = pp a++";"++pp (Seq as)
