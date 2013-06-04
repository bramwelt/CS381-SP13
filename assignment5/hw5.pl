/* 

Authors:
   Trevor Bramwell
   Emily Dunham
   Daniel Reichard

*/

/* Exercise 1 */

when(275,10).
when(261,12).
when(381,11).
when(398,12).
when(399,12).

where(275,owen102).
where(261,dear118).
where(381,cov216).
where(398,dear118).
where(399,cov216).

enroll(mary,275).
enroll(john,275).
enroll(mary,261).
enroll(john,381).
enroll(jim,399).


/* (a) schedule: S-Student, P-Place, T-Time */
schedule(S, P, T) :- enroll(S, C), when(C, T), where(C, P).

/* (b) usage: R-Room, T-Time */
usage(R, T) :- when(X, T), where(X, R).

/* (c) conflict: C1-Class1, C2-Class2 */
conflict(C1, C2) :- where(C1,X), where(C2,X), when(C1,Y), when(C2,Y), C1\=C2.

/* (d) meet: S-Student1, R-Student2 */
meet(S, R) :- schedule(S, P, T), schedule(R, P, T);
              schedule(S, P, T1), schedule(R, P, T2), T1\==T2+1.

/* Exercise 2

*****
*NOTE: length.pl and member.pl will probably be good references for this part.
*****
*/

/* (a) Define a Prolog predicate rdup(L,M) to remove duplicates from an ordered
       list L. The resulting list should be bound to M. Note that M must contain
       each element of L exactly once and in the same order as in L. You can
       assume that L is an ordered list.  */
rdup(L,M) :- rdup3(L,M,[]).
rdup3([],[],_).
rdup3([X|L],[X|M],T) :- not(member(X,T)),rdup3(L,M,[X|T]).
rdup3([X|L],[Y|M],T) :- member(X,T),rdup3(L,[Y|M],T).
rdup3([X|L],[   ],T) :- member(X,T),rdup3(L,[],T).

/* (b) Define a Prolog predicate flat(L,F) that binds to F the flat list of all
       elements in L (where L can be a possibly nested list). For example,
       flat([a,b,[c,d],[],[[[e]]],f],L) yields L = [a,b,c,d,e,f].  */

/* flat(L, F) :- */
flat(L,F) :- flat3(L,[],F).
flat3([   ],F,F).
flat3([X|L],T,F) :- flat3(X,Y,F),flat3(L,T,Y).
flat3(X,F,[X|F]) :- not(is_list(X)).

/* (c) Define a Prolog predicate project/3 that selects elements from a list by
       their position and collects them in a result list. For example, the goal
       project([2,4,5],[a,b,c,d],L) should produce the answer L=[b,d].  You can
       assume that the numbers in the first list are strictly inreasing, that is,
       your implementation does not have to care about situations like
       project([1,1,2],...) or project([2,4,3],...).  */

/* project(F, S, R) :- */

project(List,Position,Result) :- forall(nth(List,Position,_),append(nth(List,Position,Result))).
nth(L,N,X) :- nth4(L,0,N,X) .
nth4([X|L],N,N,X) :- !. 
nth4([_|L],T,N,X) :- T1 is T+1 , nth4(L,T1,N,X).
