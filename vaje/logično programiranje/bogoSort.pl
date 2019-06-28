is_sorted([]).
is_sorted([_]).
is_sorted([H1,H2|T]) :- H1 =< H2, is_sorted([H2|T]).

odstrani(X, [X|R], R).
odstrani(X, [F|R], [F|S]) :- odstrani(X, R, S).

permute([], []).
permute([X|Y], Z) :- permute(Y, W), odstrani(X, Z, W).

bogosort(A, B) :- permute(A, B), is_sorted(B).

l([1,2,3]).
l1([2,3,1]).