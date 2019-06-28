# Reference v OCaml (spremenljive spremenljivke)

```ocaml
(*
v tem primeru gre za nespremenljivo spremenljivko
*)
let x = e1;;

(*lahko jo samo na novo definiramo*)
let x = 10;;
let x = x +10;; (*x == 20*)
```
V Ocamlu moramo narediti ```referenco```, da lahko spremenljivko spreminjamo
```ocaml
(*naredimo novo referenco r z vrednostjo v*)
let r = ref v;;
(*vrednost reference dobimo:*)
!r ;;
(*določanje nove vrednosti refernece*)
r := 10;;
r := !r + 15;;
```

    Potrebno je ločiti med vrednostjo r! in refernco r - podobno kot med sprmenljivko in kazalcem v C.

# Zanke v OCaml
## While zanka
```ocaml
while <pogoj> do
    stavek1;
    stavek2;
    ...
    zadnjiStavek
done
```
```ocaml
let x = ref 2;;
let i = ref 1;;
while !i < 10 do
  x := !x + !i ;
  i := !i + 1
done
```
## for zanka
```ocaml
for <spremenljivka> = <spodnjaMeja> to <zgornjaMeja> do
    stavek1;
    stavek2;
    ...
    zadnjiStavek
done
```

## Naloge
**Naloga:** vsota prvih n členov
```ocaml
(*z while zanko*)
let vsotaN n = 
  let x = ref n in
  let i = ref 0 in
  let vsota = ref 0 in
  while !i <= !x do
    vsota := !vsota + !i;
    i := !i + 1
  done;
  !vsota

(*z for zanko*)
let vsotaFor n = 
  let x = ref n in
  let vsota = ref 0 in
  for i = 0 to !x do
    vsota := !vsota + i
  done;
  !vsota
```

**Naloga:** fibonnaccijevo število\
*Definicija Fibonnacci*:
```
F(0) = 0
F(1) = 1
F(n) = F(n-1) + F(n-2)
```
```ocaml
let fib n =
  let stevec = ref 1 in
  let a = ref 0 in
  let b = ref 1 in
  let c = ref 0 in
  while !stevec < n do
    c := !a + !b;
    a := !b;
    b := !c;
    stevec := !stevec +1
  done;
  !c
```

# Rekurzija
## Ponovitev

**Rekurzivno funkcijo definiramo kot ```let rec <ime>```**

**Naloga:** rekurzivno izračunaj vsoto prvih n števil
```ocaml
let rec vsotaR = function
    | 0 -> 0
    | n -> n + vsotaR(n-1)
```
**Naloga:** rekurzivno izračunaj Fibonaccijevo število
```ocaml
let rec fibR = function
  | 0 -> 0
  | 1 -> 1
  | n -> fibR(n-1) + fibR(n-2)
```

## Splošna pretvorba ```while``` v rekurzijo

While zanko oblike:
```java
s := s₀
while p(s) do
  s := f(s)
done ;
return r(s)
```
kjer je ```s0``` začetno stanje, ```p(s)``` pogoj. Funkcija spreminja stanje ```s -> f(s) -> s``` ter vrača rezultat ```r(s)```.

While zanko pretvorimo v rekurzijo:
```ocaml
let zanka s0 p f r =
  let rec loop s =
    if p s then loop (f s) else r s
  in
  loop s0
```
V tako rekurzijo lahko pretvorimo tudi zgornje primere:
* vsota n-tih števil
  ```ocaml
  let fibonacci3 n =
  let rec fib a b i =
    if i < n then
      fib b (a + b) (i + 1)
    else
      a
  in
  fib 0 1 0
  ```
* Fibonaccijevo število
  ```ocaml
  let vsota3 n =
  let rec vsota v i =
    if i <= n then
      vsota (v + i) (i + 1)
    else
      v
  in
  vsota 0 0
  ```
  