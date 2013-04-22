-- MiniLogo language Pretty Printer Module
--
module MLPP where

import MLSyn


ppML :: Cmd -> String
ppML (Pen a)        = "pen "++show a
ppML (MoveTo a b)   = "moveto ("++show a++","++show b++")"
ppML (Def n p c)    = "def "++n++" ("++show p++")\n"++ppML c
ppML (Call n v)     = "call "++n++" ("++show v++")"
ppML (Seq [])       = ""
ppML (Seq (a:as))   = ppML a++";"++ppML (Seq as)
