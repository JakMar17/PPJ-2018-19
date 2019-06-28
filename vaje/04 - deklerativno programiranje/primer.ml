type color = {red : float; green : float; blue: float}

type izdelek =
  | Cevelj of color * int
  | Palica of int
  | Posoda of int
  | Bucka

let z = Palica 7 ;;

let cena_z =
  match z with
  | Cevelj (b, v) -> if v < 25 then 10 else 15
  | Palica x -> 1 + 2 * x
  | Bucka -> 1040
  | Posoda 0 -> 1
  | Posoda n -> 2
;;


let h x = fun y -> x + y ;;

let f p =
  match p with
  | (_, x) -> string_of_int x

let ref fact n =
  match n with
  | 0 -> 1
  | n -> n * fact (n - 1)