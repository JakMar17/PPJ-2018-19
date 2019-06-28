type 'a stream = Cons of 'a * (unit -> 'a stream)

(* Prvih n elementov toka pretvori v seznam *)
let rec to_list n (Cons (x, s)) =
    if n = 0 then
	[]
    else
	x :: to_list (n-1) (s ())

(* n-ti element toka *)
let rec element_at n (Cons (x, s)) =
    if n = 0 then
	x
    else
	element_at (n-1) (s ())

let rec from_list s r =
  match s with
  | [] -> Cons (r, fun () -> from_list [] r)
  | x::xs -> Cons (x, fun () -> from_list xs r)

let head (Cons (x, s)) = x
let tail (Cons (x, s)) = s ()

let rec map f (Cons (x, s)) =
  Cons (f x, fun () -> map f (s ()))

let rec from n = Cons (n, fun () -> from (n+1))

let nat = from 0

let fib =
  let rec f a b = Cons (a, fun () -> f b (a+b))
  in f 0 1

let rec zip f (Cons (x, sx)) (Cons (y, sy)) =
  Cons (f x y, fun () -> zip f (sx ()) (sy ()))

let veckratniki_stevila k = map (fun n -> k*n) nat

let veckratniki =
  let rec from k = Cons (veckratniki_stevila k, fun () -> from (k+1))
  in from 0

let flatten input =
  let rec flat (Cons (s, ss)) neck = function
    | [] -> flat (ss ()) [] (neck @ [s])
    | (Cons (t, tt)) :: ts -> Cons (t, fun () -> flat (Cons (s, ss)) (neck @ [tt ()]) ts)
  in flat input [] []

let product a b = flatten (map (fun x -> map (fun y -> (x, y)) b) a)

let nuts =
  let rec f k = Cons (from (1000 * k), fun () -> f (k + 1))
  in f 0