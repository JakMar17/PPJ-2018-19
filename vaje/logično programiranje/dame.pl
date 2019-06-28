:- use_module(library(clpfd)).

safe_pair(X1/Y1, X2/Y2) :-
    X1 #\= X2,
    Y1 #\= Y2,
    abs(X2-X1) #\= abs(Y2-Y1).

safe_list(_, []).
safe_list(Z, [H | T]) :-
    safe_pair(Z, H),
    safe_list(Z, T).

safe_list2(Z, L) :- maplist(safe_pair(Z), L).

safe_list([]).
safe_list([H|T]) :- 
    safe_list(H, T),
    safe_list(T).

place_queens(N, I, []) :-
    N =< I.
place_queens(N, I, [I1/Y|T]) :-
    I #< N,
    Y in 1..N,
    I1 #= I + 1,
    place_queens(N, I1, T).

queens(N, L) :-
    place_queens(N, 0, L),
    safe_list(L),
    term_variables(L, Vars),
    label(Vars).    
