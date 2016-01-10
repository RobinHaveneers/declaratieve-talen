listlength([],0).
listlength([_|Rest],Length) :-
  listlength(Rest,LengthRest),
  Length is LengthRest + 1.

listlength_acc([],Acc, Acc).
listlength_acc([_|Rest],Acc,Length) :-
  Temp is (Acc + 1),
  listlength_acc(Rest, Temp, Length).

last([X],X).
last([_|Rest], X) :-
  last(Rest, X).

next_to([A,B|_], A, B).
next_to([_|Z], A, B) :-
  next_to(Z, A, B).

vector_sum([],[],[]).
vector_sum([A|R1],[B|R2],[L|K]) :-
  L is A+B,
  vector_sum(R1,R2,K).

look_up([pair(X,Y) | _], X, Y).

look_up([_| Rest],X,Y) :-
  look_up(Rest, X, Y).

node(a).
node(b).
node(c).
node(d).
node(e).

edge(a,b).
edge(b,c).
edge(c,d).
edge(b,d).

neighbor(X,Y) :-
  edge(X,Y);
  edge(Y,X).

path(X,Y) :-
  neighbor(X,Y).

path(X,Y) :-
  neighbor(X,Z),
  path(Z,Y),
  X \== Y.

path2(X,Y) :-
  path2(X,Y,[X]).

path2(X,Y,L) :-
  neighbor(X,Y),
  \+ member(Y,L).

path2(X,Y,L) :-
  neighbor(X,Z),
  \+ member(Z,L),
  path2(Z,Y,[Z|L]).

fib(0,0).
fib(1,1).
fib(N,F) :-
  N1 is N-1,
  fib(N1, F1),
  N2 is N-2,
  fib(N2, F2),
  F is F1+F2.


fib2(0, A, _, A).
fib2(N, A, B, F) :-
  N1 is N - 1,
  Sum is A + B,
  fib2(N1, B, Sum, F).
fib2(N, F) :-
  fib2(N, 0, 1, F).

max_one_differ(A,A).
max_one_differ(A,B) :-
  A is B+1;
  A is B-1.

depth(empty,0).
depth(node(L,_,R),D) :-
    depth(L,LD),
    depth(R,RD),
    D1 is max(LD,RD),
    D is D1 + 1.

balanced(empty) :- !.

balanced(node(L,_,R)) :-
  depth(L, Dl),
  depth(R, Dr),
  max_one_differ(Dl,Dr),
  balanced(L),
  balanced(R).

add_to(empty, V, node(empty, V, empty)).
add_to(node(L, W, R), V, node(Nl, W, Nr)) :-
  depth(L, Dl),
  depth(R, Dr),
  add_to(L,R, V, Dl, Dr, Nl, Nr).

add_to(L,R,V,Dl,Dr,L,Nr) :-
  Dl > Dr,
  add_to(R, V, Nr).

add_to(L,R,V,Dl,Dr,Nl,R) :-
  Dl =< Dr,
  add_to(L, V, Nl).

eval(int(X),_,X).
eval(var(A),List,Value) :-
  lookup(List,A, Value).
eval(plus(X,Y), List, Value) :-
  eval(X,List,Xv),
  eval(Y,List,Yv),
  Value is Xv + Yv.
eval(times(X,Y), List, Value) :-
  eval(X, List, Xv),
  eval(Y, List, Yv),
  Value is Xv*Yv.
eval(pow(X,Y), List, Value) :-
  eval(X, List, Xv),
  eval(Y, List, Yv),
  Value is Xv**Yv.
eval(min(X), List, Value) :-
  eval(X, List, Xv),
  Value is -Xv.


lookup([pair(Key,Value)|_], Key, Value).
lookup([_|Xs], Key, Value) :-
  lookup(Xs, Key, Value).
