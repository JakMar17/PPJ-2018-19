type spol = Moski | Zenska | Ostalo of string

type oseba = { ime : string; priimek : string; spol : spol }

let spostovanje {spol=s; ime=i; _} =
  match s with
  | Moski -> "SpoĹĄtovani gospod " ^ i
  | Zenska -> "SpoĹĄtovana gospa " ^ i
  | Ostalo "krneki" -> "SpoĹĄtovano " ^ i
  | Ostalo _ -> "SpoĹĄtovano " ^ i

let profesor = {ime="Andrej"; priimek="Bauer"; spol=Moski}