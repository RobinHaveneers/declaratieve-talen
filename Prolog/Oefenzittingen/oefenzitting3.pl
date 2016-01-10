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

%1. Even more classes
takes_same_course(X,Y):-
    findall((X,Y),(takes(X,A),takes(Y,A),X\=Y),Lijst1),
    list_to_set(Lijst1,Set1),
    member((X,Y),Set1).

teaches_same_course(X,Y) :-
    findall((X,Y),(teaches(X,A),teaches(Y,A),X\=Y),Lijst1),
    list_to_set(Lijst1,Set1),
    member((X,Y),Set1).

teaches_multiple_courses(X) :-
    findall(X,(teaches(X,A),teaches(X,B),A\=B),Lijst1),
    list_to_set(Lijst1,Set1),
    member(X,Set1).

inc(X,Y):-
    Y is X+1.
%2. A prelude to functional programming
map(_,[],[]).

map(P, [Xs|Xsr], [Ys|Ysr]) :-
    List =.. [P, Xs, Ys],
    call(List),
    map(P, Xsr, Ysr).

%3. Junior intepreter
interpret((G1,G2)) :-
        !,
        interpret(G1),
        interpret(G2).
interpret(true) :- !.
interpret(Head) :-
    clause(Head,Body),
    interpret(Body).

fib(0,1).
fib(1,1).
fib(N,F) :-
    N > 1,
    N2 is N - 2,
    fib(N2,F2),
    N1 is N - 1,
    fib(N1,F1),
    F is F1 + F2.
