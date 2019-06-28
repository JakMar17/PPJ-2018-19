action(stay, Tape, Tape).

action(left, []-R, []-[b|R]).
action(left, [L|Ls]-R, [Ls]-[L|R]).

action(right, L-[], [b|L]-[]).
action(right, L-[R|Rs], [R|L]-Rs).

head_rest([], b, []).
head_rest([R|Rs], R, Rs).

step(Name, L-R, State, NewL-NewR, NewState) :-
    head_rest(R, Symbol, Rs),
    program(Name, State, Symbol, NewState, NewSymbol, Action),
    action(Action, L-[NewSymbol|Rs], NewL-NewR).

run(_, final, Tape, Tape).
run(Name, State, Tape, NewTape) :-
    step(Name, Tape, State, Tape1, State1),
    run(Name, State1, Tape1, NewTape).

turing(Name, Tape, NewTape) :-
    run(Name, q0, []-Tape, L-R),
    reverse(L, Lr),
    append(Lr, R, NewTape).


% add 1
program(plus1, q0, 1, q0, 1, right).
program(plus1, q0, b, final, 1, stay).

% copy a string of 1s
program(copy, q0, b, final, b, stay).
program(copy, q0, 1, 2, b, right).
program(copy, 2, b, 3, b, right).
program(copy, 2, 1, 2, 1, right).
program(copy, 3, b, 4, 1, left).
program(copy, 3, 1, 3, 1, right).
program(copy, 4, b, 5, b, left).
program(copy, 4, 1, 4, 1, left).
program(copy, 5, b, q0, 1, right).
program(copy, 5, 1, 5, 1, left).

% produce 501 1s
program(bb5, q0, b, 1, 1, right).
program(bb5, q0, 1, 2, b, left).
program(bb5, 1, b, 2, 1, right).
program(bb5, 1, 1, 3, 1, right).
program(bb5, 2, b, q0, 1, left).
program(bb5, 2, 1, 1, b, right).
program(bb5, 3, b, 4, b, right).
program(bb5, 3, 1, final, 1, right).
program(bb5, 4, b, 2, 1, left).
program(bb5, 4, 1, q0, 1, right).