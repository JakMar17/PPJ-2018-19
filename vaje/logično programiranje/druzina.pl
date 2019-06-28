mother(X, Y) :- parent(X, Y), female(X).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

%lahko bi dali namesto neenakosti (ki mora biti na koncu), tudi diff(X,Y)
sister(X,Y) :- parent(Z, X), parent(Z, Y), female(X), X \== Y.
aunt(X,Y) :- parent(Z, Y), sister(X, Z).

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

ancestor(X, Y, [X, Y]) :- parent(X, Y).
ancestor(X, Y, [X | Z]) :- parent(X, A), ancestor(A, Y, Z).

descendant(X, Y) :- ancestor(Y, X).

clan(X, [X|_]).
clan(X, [_|T]) :- member(X, T).

insert(X, L, [X|L]).
insert(X, [H|T], [H|T1]) :- insert(X, T, T1).

reverse([], []).
reverse([H|T], L) :- reverse(T, R), append(R, [H], L).

parent(tina, william).
parent(thomas, william).
parent(thomas, sally).
parent(thomas, jeffrey).
parent(sally, andrew).
parent(sally, melanie).
parent(andrew, joanne).
parent(jill, joanne).
parent(joanne, steve).
parent(william, vanessa).
parent(william, patricia).
parent(vanessa, susan).
parent(patrick, susan).
parent(patricia, john).
parent(john, michael).
parent(john, michelle).

parent(frank, george).
parent(estelle, george).
parent(morty, jerry).
parent(helen, jerry).
parent(jerry, anna).
parent(elaine, anna).
parent(elaine, kramer).
parent(george, kramer).

parent(margaret, nevia).
parent(margaret, alessandro).
parent(ana, aleksander).
parent(aleksandr, aleksander).
parent(nevia, luana).
parent(aleksander, luana).
parent(nevia, daniela).
parent(aleksander, daniela).


male(william).
male(thomas).
male(jeffrey).
male(andrew).
male(steve).
male(patrick).
male(john).
male(michael).
male(frank).
male(george).
male(morty).
male(jerry).
male(kramer).
male(aleksandr).
male(alessandro).
male(aleksander).

female(tina).
female(sally).
female(melanie).
female(joanne).
female(jill).
female(vanessa).
female(patricia).
female(susan).
female(michelle).
female(estelle).
female(helen).
female(elaine).
female(anna).
female(margaret).
female(ana).
female(nevia).
female(luana).
female(daniela).

