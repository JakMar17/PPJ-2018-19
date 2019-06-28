:- use_module(library(clpfd)).

bought(eva, bread, 1).      % Eva je kupila 1 kg kruha
bought(tomi, beer, 6).      % Tomi je kupil 6 litrov piva
bought(eva, butter, 2).     % Eva je kupila tudi 2 kg jabolk
bought(tina, beer, 2).
bought(tina, salami, 1).

price(beer, 2).    % liter piva stane 2 €
price(apples, 1).  % kg jabolk pa 1 €
price(bread, 3).
price(salami, 17).

%predikat all_equal(L) velja, če so vsi elementi v listu L enaki
all_equal([]).
all_equal([_]).
all_equal([H, H|T]) :-
    all_equal([H | T]).