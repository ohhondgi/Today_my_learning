module F = Format

type value = 
  | NumV of int 
  | BoolV of bool
and t = (string * value) list

let empty = []

let insert x n s =
    (x,n)::s

let rec find x s =
  match s with
  | [] -> failwith ("Free identifier " ^ x)
  | (x', n) :: t -> if x' = x then n else find x t

let pp_v fmt v =
  match v with
  | NumV i -> F.fprintf fmt "%d" i
  | BoolV b -> F.fprintf fmt "%b" b

let pp fmt s = 
  let rec pp_impl fmt s = 
    match s with
    | [] -> F.fprintf fmt "]"
    | (x, v) :: t -> F.fprintf fmt "(%s, %a) %a" x pp_v v pp_impl t
  in
  F.fprintf fmt "[ %a" pp_impl s
