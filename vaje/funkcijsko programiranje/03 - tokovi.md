# Programiranje s tokovi

## Definicija toka
V Ocaml ne moremo imeti neskončnih tokov, lahko pa jih simuliramo z uporabo `stream`:
```ocaml
type 'a stream = Cons of 'a * (unit -> stream)
```

## Tok iz seznama

**Naloga:** izraz `from_list [e1, e2, ... ei] r` vrne neskončen tok, kjer je prvih i elementov elementov seznama, vsi nadaljni pa so element `r`.

```ocaml
let rec from_list s r =
  match s with
  | [] -> Cons (r, fun () -> from_list [] r)
  | x::xs -> Cons (x, fun () -> from_list xs r)
```

## Seznam iz toka
**Naloga:** sestavimo še obratno funkcijo, ki iz toka prebere prvih n znakov in jih zapiše v tabelo.

>Uporaba: `to_list n stream`

```ocaml
let rec to_list n (Cons (x,s)) = 
  if n = 0 then
    []
  else
    x :: to_list (n-1) (s ())
```

## N-ti element toka
**Naloga:** vrni n-ti element toka,
>Uporaba: `element_at <st> <imeToka>`
```ocaml
let rec element_at n (Cons (x,s)) = 
    if n = 0 then
      x
    else
      element_at (n-1) (s ())
```

## Primer uporabe
```ocaml
(*skripta*)
type 'a stream = Cons of 'a * (unit -> 'a stream)

let rec from_list s r =
  match s with
  | [] -> Cons (r, fun () -> from_list [] r)
  | x::xs -> Cons (x, fun () -> from_list xs r)

let rec to_list n (Cons (x,s)) = 
  if n = 0 then
    []
  else
    x :: to_list (n-1) (s ())

(*konzola*)
let list = [1; 2; 3; 4; 5];;
let stream = from_list list 420;;
to_list 5 stream;;
element_at 420 stream;;
```
## Head&tail

**Naloga:** funkcija naj vrača glavo toka
>Uporaba: `head <imeToka>;;`
**Naloga:** funkcija naj vrača rep toka (brez prvega elementa)
>Uporaba: `tail <imeToka>;;
```ocaml
let head (Cons (x, s)) = x
let tail (Cons (x, s)) = s()
```

## Funkcija `mat`
**Naloga:** funkcija naj sprejme funkcijo `f` ter tok `s`. Funkcija `f` naj se izvede nad vsemi elemnti tok `s`.
>Uporaba: `map (<funkcija>) <ime toka>;;`\
Primer: `to_list 10 (map (fun x -> x*x) tokS);;`

```ocaml
let rec map f (Cons(x, s)) = 
  Cons (f x, fun() -> map f (s ()))
```

## Funkcija `nat`
**Naloga:** funkcija vrača tok naravnih števil
>Uporaba: nat;;\
Primer: let tok = nat;;

```ocaml
(*
Uporabljali bomo pomožno funkcijo, ki bo v tok dodala vsa  števila od k naprej.
*)

let rec from k = Cons(k, fun() -> from (k+1))

let nat = from 0
```

## Fibonaccijeva števila

**Naloga:** funkcija vrača tok Fibonaccijevih števil
>Uporaba: fib;;\
Primer: let tok = fib;;

```ocaml
(*
Uporabljali bomo pomožno funkcijo, ki bo v tok dodala vsa  števila od k naprej.
*)

let rec from k = Cons(k, fun() -> from (k+1))

let nat = from 0
```

## Preslikovanje parov

**Naloga:** Sestavite funkcijo, ki sprejme funkcijo f in toka
`d₁, d₂, d₃, ...`;  `e₁, e₂, e₃, ...` ter vrne tok `f d₁ e₁, f d₂ e₂, f d₃ e₃, ...`
>Uporaba: zip <funkcija> <tok1> <tok2>;;\
Primer: to_list 10 (zip (fun x -> fun y -> x + y) nat (tail nat)) ;;

```ocaml
let rec zip f (Cons(x, sx)) (Cons(y, sy)) = 
  Cons(f x y, fun() -> zip f (sy()) (sy()))
```

## Večkratniki
### Večkratniki števila
**Naloga:** Sestavite funkcijo, ki vrača tok z večkratniki števila x
>Uporaba: veckratniki_stevila <stevilo>;;\


```ocaml
let veckratniki_stevila k = map (fun n -> n*k) nat
```

### Tokovi večkratnikov
**Naloga:** Sestavite funkcijo, ki vrača tokove s tokovi večkratnikov naravnih števil
>Uporaba: veckratniki;;\
Primer: to_list 10 (map (to_list 15) veckratniki) ;;


```ocaml
let from k = Cons (k, fun() -> from (k+1))

let veckratniki_stevila k = map (fun n -> k *n) nat

let veckratniki = 
  let rec from k = Cons (veckratniki_stevila k, fun() -> from (k+1))
  in from 0 
```

## Tokovi parov
### Sploščen tok
**Naloga:** Sestavite funkcijo, sprejme tok tokov in vrača tok, v katerem se vsak element pojavi samo enkrat
>Uporaba: flatten <tok tokov>;;\


```ocaml
let flatten input =
  let rec flat (Cons (s, ss)) neck = function
    | [] -> flat (ss ()) [] (neck @ [s])
    | (Cons (t, tt)) :: ts -> Cons (t, fun () -> flat (Cons (s, ss)) (neck @ [tt ()]) ts)
  in flat input [] []
```