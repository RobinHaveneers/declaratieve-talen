teaches(berbers,bs).
teaches(berbers,iw).
teaches(demoen,ab).
teaches(demoen,cc).
teaches(holvoet,bvp).
teaches(moens,bvp).
teaches(danny,ai).
teaches(maurice,ai).
teaches(dedecker,socs).

takes(tom,bs).
takes(tom,bvp).
takes(tom,socs).
takes(maarten,socs).
takes(maarten,bs).
takes(pieter,bvp).

takes_same_course(X,Y) :-
  findall((A,B), (takes(A,V),takes(B,V),A \== B),L),
  list_to_set(L,S),
  member((X,Y),S).

teach_same_course(X,Y) :-
  findall((A,B), (teaches(A,V), teaches(B,V), A\==B),L),
  list_to_set(L,S),
  member((X,Y),S).

teaches_multiple_courses(X) :-
  findall(T,(teaches(T,V1), teaches(T,V2), V1\==V2), L),
  list_to_set(L,S),
  member(X,S).

inc(X,Y) :- Y is X+1.

map(_,[],[]).

map(P,[X|Xs],[Y|Ys]) :-
  F =.. [P, X, Y],
  call(F),
  map(P, Xs, Ys).

move(right, tape(Ls, Symbol, []), tape([Ls|Symbol], #, [])).
move(rght, tape(Ls, Symbol, [R|Rs]), tape([Ls|Symbol], R, Rs)).

move(left, tape([], Symbol, Rs), tape([], #, [Symbol|Rs])).
move(left, tape([L|Ls], Symbol, Rs), tape(Ls, L, [Symbol|Rs])).

move(wait, Tape, Tape).

read(tape(_,Symbol,_), Symbol).

write(Write, tape(L,_,R), tape(L, Write, R)).
