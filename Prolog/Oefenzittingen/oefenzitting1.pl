father(anton,bart).
father(anton,daan).
father(anton,elisa).
father(fabian,anton).

mother(celine,bart).
mother(celine,daan).
mother(celine,gerda).
mother(gerda,hendrik).

sibling(X,Y) :-
    father(F,X),
    father(F,Y),
    mother(M,X),
    mother(M,Y),
    X \== Y.


ancestor(X,Y) :- father(X,Y).

ancestor(X,Y) :-
	father(Z,Y),
	ancestor(X,Z).

peano_plus(zero,B,B).
peano_plus(s(A),B,s(C)) :- peano_plus(A,B,C).

% Normale peano min
peano_min(D,zero,D).
peano_min(s(D),s(E),F) :- peano_min(D,E,F).

greater_than(s(_),zero).
greater_than(s(X),s(Y)) :-
  greater_than(X, Y).

maximum(A, zero, A).
maximum(zero, A, A).
maximum(s(A), s(B), s(R)) :-
  maximum(A,B,R).

depth(nil, 0).
depth(node(L,_,R), D) :-
  Dt is 1,
  depth(L,X),
  depth(R,Y),
  D is (Dt + max(X,Y)).

eval(tru, tru).
eval(fal, fal).

eval(and(X,Y),R) :-
  eval(X, A),
  eval(Y, B),
  (
  A=tru, B=tru
  -> R=tru
  ;  R=fal
  ).

eval(or(X,Y),R) :-
  eval(X,A),
  eval(Y,B),
  (
  A=fal, B=fal
  -> R=fal
  ;  R=tru
  ).

eval(not(tru),fal).
eval(not(fal),tru).
