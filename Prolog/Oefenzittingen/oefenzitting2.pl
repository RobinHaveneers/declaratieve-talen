listlength([],0).
listlength([_|Rest],Length) :-
        listlength(Rest,LengthRest),
        Length is LengthRest + 1.

listlength_acc([], Lengte, Lengte).
listlength_acc([_|Rest],Som,Lengte) :-
	Count is Som + 1,
    listlength_acc(Rest,Count,Lengte).

% Uitvoeren query op vorige functies. Accumulator moet geinstantieerd worden op 0.
% listlength_acc([3,1,2],0,Length).

last([X], X).
last([_|Rest],X) :-
     last(Rest, X).

next_to([X,Y|_],X,Y).
next_to([_|Z],X,Y) :-
    next_to(Z,X,Y).

vector_sum([],[],[]).
vector_sum([X|Y],[A|B],[L|K]):-
    L is X+A,
    vector_sum(Y,B,K).

look_up([pair(X,Y)|_],X,Y).
look_up([_|Rest],X,Y):-
    look_up(Rest,X,Y).

node(a).
node(b).
node(c).
node(d).
node(e).

edge(a,b).
edge(b,c).
edge(b,d).

neighbor(X,Y) :-
    edge(X,Y);
    edge(Y,X).

path(X,Y) :-
    neighbor(X,Z),
    path(Z,Y),
    X \== Y.
