# OCaml - cheat sheat
### Zagon .ml programa

V OCaml konzoli poženemo ukaz

    ocaml
    #use "imeDatoteke.ml" ;;

Za izhod iz OCaml uporabimo ```Ctrl+Z``` in ```Enter```

### Komentarji
```ocaml
    (*
        moj mali komentar
    *)
```

### Switch stavek

Spodnja funkcija primerja argument.spremenljivka s prva, druga,... možnost in ima narejen default:

```ocaml
let primerjava&izpis argument = 
    (
        match argument.spremenljivka with
        | <prva možnost> -> <nekej>
        | <druga možnost> -> <nekej>
        | ...
        | _ -> <sicer>
    )
```

### Polje (array)

```ocaml
type <tipPolja> =
| <prvo polje> of <vrsta/tip polja (string, int,...)>
| <drugo polje> of <tip spremenljivke>
| ...

let <ime mojega polja> = [
    <prvo polje> vrednost;
    <drugo polje> vrednost;
    ...
]
```

*Kaj lahko še počnem s polji?*
* definiram polje tipa int
  ```ocaml
  let <ime polja> = [1; 2; 3; 4];;
  ```
* dostopam do glave polja
  ```ocaml
  List.hd <ime polja>;;
  ```
* dostopam do repa polja
  ```ocaml
  List.tl <ime polja>;;
  ```
* na vsakem elementu kličem funkcijo
  ```ocaml
  let <ime novega polja> = List.map <ime funkcije> <ime polja> ;;
  ```
* kvadriramo vsak element seznama s pomočjo anonimne (λ) funkcije
  ```ocaml
  let nizi = List.map (fun x -> x*x) stevila ;;
  ```

## Podatkovni tipi

### Vrste spremenljivk
* int
* string

### Definicija podatkovnega tipa in uporaba

Sestavljen podatkovni tip najprej definiramo z rezervirano besedo ```type```.

```ocaml
type <imePodatkovnegaTipa> = {
    <ime prve spremenljivke> : <tip spremenljivke>;
    <ime druge spremeljivke> : <tip spremenljivke>
} ;;
```

### Določanje spremenljivke

Podatkovni tip inicializiramo z rezervirano besedo ```let```.

```ocaml
let <imeSpremenljivke> = {
    <ime prve spremenljivke> = <vrednost>; 
    <ime druge spremenljivke> = <vrednost>
} ;;
```

### Izpis vrednosti spremenljivke

V konzoli:

```ocaml
<imeSpremenljivke>.imePrveSpremenljivke;;
```

Primer izpisa:
```ocaml
- : <tip spremenljivke> = <vrednost spremenljivke>
```

### Funkcije

Definicija funkcije:
```ocaml
let <imeFunkcije> <argument1> <argument2> <...> = 
    (*
        tu je telo funkcije
        čas je, da nekaj narediš
    *)
```

Uporaba funkcije ```<ime funkcije> <argumnet1> <argumnet2> <...> ```

#### Funkcija izpis

```ocaml
let izpis argument = 
    argument.prvaSpremenljivka ^ " " ^
    string_of_int argument.intSpremenljivka
```

Funkcija izpiše prvo in drugo spremenljivko, ki se nahajata v spremenljivki argument.\
``` ^ ``` uporabljamo kot 'concat' (+ v Javi)



