# Množice
## Opis množice (signatura)
```ocaml
type order = Less | Equal | Greater

module type SET =
sig
    type element
    val cmp : element -> element -> order
    type set
    val empty : set
    val member : element -> set -> bool
    val add : element -> set -> set
    val remove : element -> set -> set
    val to_list : set -> element list
end
```
V množici se vsak element lahko pojavi samo enkrat. Tip elementov, ki jih vsebuje množica, mora biti primerljiv – elemente primerjamo s funkcijo `cmp`, ki vrne `Less`, `Equal` ali `Greater`. Množica podpira naslednje operacije:

* `member e s` vrne `true`, če množica `s` vsebuje element `e`,
* `add e s` doda element `e` v množico `s`,
* `remove e s` izbriše element `e` iz množice `s`,
* `to_list s` vrne seznam elementov v množici `s` (v poljubnem vrstnem redu).

## Implementacija s seznamom
**Naloga:** Definirajte strukturo IntListSet, ki elemente množice hrani v seznamu. 

>Uporaba: `IntListSet.add <element>;;`\
>Primer: `let s = IntListSet.add 2 (IntListSet.add 4 IntListSet.empty) ;;`

```ocaml
(*
najprej si definiramo pomožno metodo za primerjanje dveh int
*)

ype order = Manj | Enako | Vec

let primerjaj x y =
  match compare x y with
  | 0 -> Enako
  | r when r < 0 -> Manj
  | _ -> Vec


module type SET =
  sig
    type element
    val cmp : element -> element -> order
    type set
    val empty : set
    val member : element -> set -> bool
    val add : element -> set -> set
    val remove : element -> set -> set
    val to_list : set -> element list
    val fold : ('a -> element -> 'a) -> 'a -> set -> 'a
  end

module IntListSet : SET with type element = int =
  struct
    type element = int
    let cmp = primerjaj
    type set = int list
    let empty = []
    
    let rec member x = function
      | [] -> false
      | y :: ys -> (x = y) || member x ys
    
    let add x ys = if member x ys then ys else (x :: ys)

    let rec remove x = function
      | [] -> []
      | y :: ys -> if x = y then ys else y :: remove x ys

    let to_list ys = ys

    let rec fold f x = function
      | [] -> x
      | y :: ys -> fold f (f x y) ys
  end

```