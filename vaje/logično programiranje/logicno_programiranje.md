# Logično programiranje v Prolog

- [Logično programiranje v Prolog](#Logi%C4%8Dno-programiranje-v-Prolog)
  - [Osnove](#Osnove)
  - [Seznami](#Seznami)
    - [`member/2`](#member2)
    - [`insert/3`](#insert3)
    - [`reverse/3`](#reverse3)
  - [Družinska razmerja](#Dru%C5%BEinska-razmerja)
    - [Osnovni](#Osnovni)
    - [`mother/2`](#mother2)
    - [`granparent/2`](#granparent2)
    - [`sister/2`](#sister2)
    - [`aunt/2`](#aunt2)
    - [`ancestor/2`](#ancestor2)
    - [`descendant/2`](#descendant2)
    - [`ancestor/3`](#ancestor3)
  - [BogoSort](#BogoSort)
    - [`is_sorted/1`](#issorted1)
    - [`permute/2`](#permute2)
    - [`bogosort/2`](#bogosort2)
  - [Turingov stroj](#Turingov-stroj)
    - [`action/3`](#action3)
    - [`head_rest/3`](#headrest3)
    - [`step/5`](#step5)
    - [`run/4`](#run4)
    - [`turing/3`](#turing3)
- [Logično programiranje z omejitvami v Prolog](#Logi%C4%8Dno-programiranje-z-omejitvami-v-Prolog)
  - [Direktiva za delo z omejitvami](#Direktiva-za-delo-z-omejitvami)
  - [Končna domena celih števil `clpfd`](#Kon%C4%8Dna-domena-celih-%C5%A1tevil-clpfd)
  - [Jedilnik](#Jedilnik)
    - [`kosilo/1`](#kosilo1)
    - [`vege_kosilo/1`](#vegekosilo1)
    - [`ustrezno_kosilo/1`](#ustreznokosilo1)
  - [Problem `n` dam](#Problem-n-dam)
  - [`safe_pair/2`](#safepair2)
  - [`safe_list/2`](#safelist2)
  - [`safe_list/1`](#safelist1)
  - [`place_queens/3`](#placequeens3)
  - [`queens/2`](#queens2)

## Osnove
* nalaganje programa v konzolo
    ```prolog
    [<imeprograma>.pl].
    ```
* pisanje poizvedbe\
  **brez presledka med imenom in oklepajem; na koncu pika**
  ```prolog
  <ime poizvedbe>(argument, argument).
  ```
* zakluček poizvedbe `.`
* naslednja rešitev `;` ali `n`
* v poizvedbah
  * `,` in
  * `;` ali
  * `:-` implikacija
  * `\==` neenako

## Seznami
Sezname pišemo z oglatimi oklepaji, vsebujejo lahko karkoli.
```prolog
L = [1,2,3,4].
L = [1, a, foo(4,5), [a,b,c], 3.14].
```
Z združevanjem lahko dostopamo do glave in repa.
```prolog
[H|T] = [1,2,3,4].
H = 1,
T = [2,3,4].

H = 1, T = [2,3,4], L = [H|T].
L = [1,2,3,4].
```

Sezname lahko združujemo z `append/3`
```prolog
append([1,2], [3,4], L).
L = [1,2,3,4].

append(A, B, [1,2,3]).
A = [],
B = [1, 2, 3] ;
A = [1],
B = [2, 3] ;
A = [1, 2],
B = [3] ;
A = [1, 2, 3],
B = [].
```

### `member/2`
Predikat `mamber(X, Y)` velja, ko je `X` element seznama `L`.
```prolog
clan(X, [X|_]).
clan(X, [_|T]) :- member(X, T).
```

### `insert/3`
Predikat `insert(X, L1, L2)` vstavi na poljubno mesto v seznamu `L1` element `X` 
```prolog
insert(X, L, [X|L]).
insert(X, [H|T], [H|T1]) :- insert(X, T, T1).
```

### `reverse/3`
Predikat `reverse(L1, L2)` obrne seznam `L1`.
```prolog
reverse([], []).
reverse([H|T], L) :- reverse(T, R), append(R, [H], L).
```

## Družinska razmerja
### Osnovni
```prolog
%starš
parent(<ime starša>, <ime otroka>).
%moški
male(ime).
%ženska
female(ime).
```

### `mother/2`
Predikat `mother(X, Y)` velja, ko je `X` mama od `Y`.
```prolog
mother(X, Y) :- parent(X, Y), female(X).
```

### `granparent/2`
Predikat `grandparent(X, Y)` velja, ko je `X` stari starš od `Y`.
```prolog
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
```

### `sister/2`
Predikat `sister(X, Y)` velja, ko je `X` sestra od `Y`.
```prolog
% X \== Y mora biti na koncu, ko sta X in Y že določena
sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), X \== Y.

%dif(X, Y) je lahko kjerkoli
sister(X, Y) :- dif(X, Y), parent(Z, X), parent(Z, Y), female(X).
```

### `aunt/2`
Predikat `aunt(X, Y)` velja, ko je `X` teta od `Y`.
```prolog
aunt(X, Y) :- parent(Z, Y), sister(X, Z).
```

### `ancestor/2`
Predikat `ancestor(X, Y)` velja, ko je `X` prednik od `Y`.
```prolog
%končni pogoj
ancestor(X, Y) :- parent(X, Y).
%rekurzija
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
```

### `descendant/2`
Predikat `descendant(X, Y)` velja, ko je `X` potomec od `Y`.
```prolog
%ravno obraten pogoj kot pri prednikih
descendant(X, Y) :- ancestor(Y, X):

%ali daljše
    %končni pogoj
    descendant(X, Y) :- parent(Y, X).
    %rekurzija
    descendant(X, Y) :- parent(Y, Z), descandant(X, Z).
```

### `ancestor/3`
Predikat `ancestor(X, Y, L)` velja, ko je `X` prednik od `Y`, v seznam `L` shranjuje pot.
```prolog
ancestor(X, Y, [X, Y]) :- parent(X, Y).
ancestor(X, Y, [X | Z]) :- parent(X, A), ancestor(A, Y, Z).
```

## BogoSort

### `is_sorted/1`
Predikat `is_sorted(L)` velja, če je dani seznam `L` nepadajoče ureje.
```prolog
is_sorted([]).
is_sorted([_]).
is_sorted([H1,H2|T]) :- H1 =< H2, is_sorted([H2|T]).
```

### `permute/2`
Predikat `permute(L, Z)` velja, če je seznam `Z` permutiran seznam `L`.
```prolog
odstrani(X, [X|R], R).
odstrani(X, [F|R], [F|S]) :- odstrani(X, R, S).

permute([], []).
permute([X|Y], Z) :- permute(Y, W), odstrani(X, Z, W).
```

### `bogosort/2`
Predikat `bogosort(A, B)` velja, če so elementi seznama A nepadajoče urejeni v seznamu B.
```prolog
bogosort(A, B) :- permute(A, B), is_sorted(B)..
```

## Turingov stroj

>Turingov stroj namesto RAMa uporablja neskončni trak celic, v katerih hrani simbole izbrane abecede (pogosto sta to `0` in `1`). Glava bere in piše iz trenutne celice ter se lahko pomika za eno mesto levo ali desno. V vsakem trenutku je stroj v enem od končno mnogo stanj.<br><br>
>Program za Turingov stroj sestoji iz nabora ukazov. Na podlagi programa stroj na vsakem koraku glede na trenutni simbol in stanje na trak zapiše nov simbol, premakne glavo v levo ali desno (ali jo pusti na mestu) in se postavi v novo stanje (ki je lahko enako prejšnjemu). Program bomo zapisali z naborom pravil, ki ga podamo s predikatom `program/6`:\ <br><br>
>   `program(Name, InState, InSymbol, OutState, OutSymbol, Direction)`\ <br><br>
Argument `Name` pove ime programa in povezuje vsa pravila za določen program. `InState` in `InSymbol` sta stanje stroja in simbol v celici pod glavo, pri katerih uporabimo to pravilo. `OutState` pove stanje, v katerem bo stroj po tem ukazu. `OutSymbol` je nov simbol, ki naj se zapiše v trenutno celico, `Direction` pa smer, v katero naj se premakne glava.

### `action/3`

>»Neskončni« trak predstavimo z dvema seznamoma. Seznam L vsebuje simbole na traku levo od glave, seznam R pa simbole desno od glave (vključno s simbolom, ki je trenutno pod glavo). Poleg tega bomo zaradi lažjega dostopanja seznam L hranili v obratnem vrstnem redu.

>Prazno celico predstavimo s simbolom `b`. Celoten trak bomo predstavili s strukturo oblike `L-R`. Tukaj operator `-` ne pomeni odštevanja, temveč le povezuje seznama L in R v eno strukturo.

Definirajte predikat action(Direction, InL-InR, OutL-OutR), ki glavo premakne v dano smer (Direction je lahko left, right ali stay).

```prolog
action(stay, Tape, Tape).

action(left, []-R, []-[b|R]).
action(left, [L|Ls]-R, [Ls]-[L|R]).

action(right, L-[], [b|L]-[]).
action(right, L-[R|Rs], [R|L]-Rs).
```

### `head_rest/3`

>Trenutni simbol pod glavo lahko s traku `L-R` dobimo tako, da vzamemo prvi element seznama `R`. Lahko pa se zgodi, da je `R` prazen. 

Definirajte pomožni predikat `head_rest(R, Head, Rest)`, ki iz trenutnega seznama na desni `R` dobi element `Head` pod glavo in preostanek seznama `Rest`. 

```prolog
head_rest([], b, []).
head_rest([R|Rs], R, Rs).
```

### `step/5`

Definirajte predikat `step(Name, InL-InR, InState, OutL-OutR, OutState)`, ki izvede en korak na Turingovem stroju s programom `Name` pri vsebini traku `InL-InR` in stanju `InState`.

```prolog
step(Name, L-R, State, NewL-NewR, NewState) :-
    head_rest(R, Symbol, Rs),
    program(Name, State, Symbol, NewState, NewSymbol, Action),
    action(Action, L-[NewSymbol|Rs], NewL-NewR).
```

### `run/4`

Definirajte predikat `run(Name, State, InL-InR, OutL-OutR)`, ki požene program `Name` iz začetnega stanja State in vhodnega traku `InL-InR` do konca:
* če je v stanju `final`, se ustavi;
* sicer izvede en korak in znova pokliče `run/4`.

```prolog
run(_, final, Tape, Tape).
run(Name, State, Tape, NewTape) :-
    step(Name, Tape, State, Tape1, State1),
    run(Name, State1, Tape1, NewTape).
```

### `turing/3`

Definirajte predikat `turing(Name, InTape, OutTape)`, ki izvede program `Name` na vhodnem traku `[]-InTape`. Argument `InTape` je torej le seznam simbolov desno od glave. Tudi `OutTape` naj je navaden seznam vseh simbolov na traku v pravem vrstnem redu. Iz strukture `L-R` ga dobimo tako, da `L` obrnemo in ga staknemo z `R`.

```prolog
turing(Name, Tape, NewTape) :-
    run(Name, q0, []-Tape, L-R),
    reverse(L, Lr),
    append(Lr, R, NewTape).
```

# Logično programiranje z omejitvami v Prolog

## Direktiva za delo z omejitvami
Za programiranje z omejitvami moramo na začetek programa zapisati direktivo:
```prolog
%končna domena celih števil:
:- use_module(library(clpfd)).

%domena realnih števil:
:- use_module(library(clpr)).
```

## Končna domena celih števil `clpfd`
Končna domena celih števil omogoča naslednje operacije
```
+   -   *   ^   min   max   mod   rem   abs   //   div
#=   #\=   #>=   #=<   #>   #<
```

Za vsako spremenljivko lahko določimo njeno končno domeno oz. interval:
```prolog
A in 0..42.
/*
    inf -> min (- infinity)
    sup -> max (+ infinity)
*/
B in inf..sup.

%določimo vrednosti vsem sprmenljivka tabele
[A,B,C] ins 1..10.
```

Za določanjerazličnih vrednosti spremenljivk (`A`, `B` in `C` bodo imele različne vrednosti):
```prolog
all_distinct([A,B,C]).
```

S predikatom `label` zahtevamo primere rešitev:
```prolog
label([A, B, C]).
```

## Jedilnik
> jedilnik.pl

```prolog
:- use_module(library(clpfd)).
```


### `kosilo/1`
Kosilo je sestavljeno iz 1) glavne jedi in priloge ter 2) dveh dodatkov, ki jih izberemo izmed predjedi, sadja in sladice. Napišite predikat `kosilo(Seznam)`, ki vrača različne kombinacije štirih jedi, ki sestavljajo kosilo.

```prolog
kosilo([GLAVNA_JED, PRILOGA, DODATEK1, DODATEK2]) :-
    glavna_jed(GLAVNA_JED),
    priloga(PRILOGA),
    (sadje(DODATEK1), predjed(DODATEK2); 
     sadje(DODATEK1), sladica(DODATEK2);
     predjed(DODATEK1), sladica(DODATEK2)).
```

### `vege_kosilo/1`
Predikat `vege_kosilo(K)` je veljaven, ko je K vege kosilo.

```prolog
vege_kosilo([GLAVNA_JED, PRILOGA, DODATEK1, DODATEK2]) :-
    kosilo([GLAVNA_JED, PRILOGA, DODATEK1, DODATEK2]),
    vege(GLAVNA_JED),
    vege(PRILOGA),
    vege(DODATEK1),
    vege(DODATEK2).

vege_kosilo2(Kosilo) :-
    kosilo(Kosilo),
    maplist(vege, Kosilo).

mesno_kosilo(Kosilo) :-
    kosilo(Kosilo),
    not(maplist(vege, Kosilo)).
```

### `ustrezno_kosilo/1`
Napišite predikat `ustrezno_kosilo(Kosilo, MaxCena, MinKalorij, MaxKalorij, MinBeljakovin, MinOH)`, ki preveri, ali kosilo `K` ustreza naslednjim pogojem:
* cenejše od MaxCena,
* vsaj MinKalorij in največ MaxKalorij,
* vsaj MinBeljakovin ter
* vsaj MinOH ogljikovih hidratov.

```prolog
ustrezno_kosilo([Kosilo, MaxCena, MinKalorij, MaxKalorij, MinBeljakovin, MinOH]) :-
    kosilo(Kosilo),
    profitno_kosilo([Kosilo, MaxCena]), 
    
    maplist(kalorije, Kosilo, K),
    sum(K, #>=, MinKalorij),
    sum(K, #=<, MaxKalorij),
    
    maplist(beljakovine, Kosilo, B),
    sum(B, #>=, MinBeljakovin),
    
    maplist(ogljikovi_hidrati, Kosilo, O),
    sum(O, #>=, MinOH).

profitno_kosilo([Kosilo, MaxCena]) :-
    maplist(cena, Kosilo, SkupajCena),
    sum(SkupajCena, #=<, MaxCena).
```

Z ustrezno poizvedbo poiščite različna kosila, ki stanejo največ 5.00 € in vsebujejo vsaj 900 kalorij ter vsaj 50 g beljakovin.
```prolog
ustrezno_kosilo([K, 500, 900, _, 50, _]).
```

Poizvedbo razširite tako, da bo vračala samo vegetarijanska kosila.
```prolog
vege_kosilo(K), ustrezno_kosilo([K, 500, 900, _, 50, _]).
```

## Problem `n` dam
>**Opis problema**:\
>Na šahovnico velikost `n*n` želimo postaviti `n` kraljic, ki se medsebojno ne napadajo _(kraljica napada vodoravno, navpično ali diagonalno)_.

>Koordinate figur bomo zapislovali v obliki `X/Y`.

## `safe_pair/2`
Predikat `safe_pair(X1/Y1, X2/Y2)` je veljaven, ko se dami na poljih `X1/Y1` in `X2/Y2` ne napadata.
```ocaml
:- use_module(library(clpfd)).

safe_pair(X1/Y1, X2/Y2) :-
    X1 #\= X2,
    Y1 #\= Y2,
    abs(X2-X1) #\= abs(Y2-Y1).
```

## `safe_list/2`
Napišite predikat `safe_list(X/Y, L)`, ki sprejme koordinate ene dame in seznam koordinat preostalih dam ter preveri, da dama na koordinatah `X/Y` ne napada nobene v seznamu.
```ocaml
safe_list(_, []).
safe_list(Z, [H | T]) :-
    safe_pair(Z, H),
    safe_list(Z, T).


safe_list2(Z, L) :- maplist(safe_pair(Z), L).
```

## `safe_list/1`
Napišite predikat `safe_list(L)`, ki sprejme seznam koordinat in preveri, da se med sabo ne napada noben par dam v seznamu.

```prolog
safe_list([]).
safe_list([H|T]) :- 
    safe_list(H, T),
    safe_list(T).
```

## `place_queens/3`
Napišite predikat `place_queens(N, I, L)`, ki na šahovnico velikosti `N×N` razporedi `N` dam tako, da je vsaka v svojem stolpcu (ima svojo koordinato `X`). Predikat naj vrne koordinate v seznamu `L`. I je pomožen parameter, ki hrani trenutno vrednost koordinate `X`.

```prolog
place_queens(N, I, []) :-
    N =< I.
place_queens(N, I, [I1/Y|T]) :-
    I #< N,
    Y in 1..N,
    I1 #= I + 1,
    place_queens(N, I1, T).
``` 

>Predikat `term_variables(L, Vars)` poišče vse spremenljivke v izrazu (seznamu) `L` in jih shrani v seznam `Vars`, na katerem lahko potem pokličemo `label/1`.

## `queens/2`
Napišite predikat ``queens(N, L)``, ki na šahovnico velikosti `N×N` razporedi `N` dam tako, da se med sabo ne napadajo. Njihove koordinate naj vrne v seznamu `L`.

```prolog
queens(N, L) :-
    place_queens(N, 0, L),
    safe_list(L),
    term_variables(L, Vars),
    label(Vars).
```