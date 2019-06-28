:- use_module(library(clpfd)).

meeting(X, Y) :-
    X + Y #= 22,
    2 * X + 4 * Y #= 72,
    label([X, Y]).