%% HARDCODE APPROACH, BAD PRACTICE

relevant_number([X,Y], Lim, Result) :-
    single_value([X,Y], Lim, ResultSingle),
    combinations([X,Y], Lim, ResultCombo),
    append(ResultSingle, ResultCombo, AllSols),
    list_to_set(AllSols, Set),
    member(Result, Set).

single_value([X,Y], Lim, [X,Y]) :-
    X =< Lim,
    Y =< Lim.
single_value([X,Y], Lim, [X]) :-
    X =< Lim,
    Y > Lim.
single_value([X,Y], Lim, [Y]) :-
    X > Lim,
    Y =< Lim.

combinations([X,Y], Lim, ListResult) :-
    atom_concat(X,Y,XY),
    atom_concat(Y,X,YX),
   	atom_concat(X,X,XX),
    atom_concat(Y,Y,YY),
    atom_number(XY, Result1),
    Result1=<Lim,
    append([Result1], [], Temp1),
    atom_number(XX, Result2),
    Result2=<Lim,
    append([Result2], Temp1, Temp2),
    atom_number(YX, Result3),
    Result3=<Lim,
    append([Result3], Temp2, Temp3),
    atom_number(YY, Result4),
    Result4=<Lim,
    append([Result4], Temp3, ListResult).
