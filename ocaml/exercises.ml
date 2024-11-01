exception Negative_Amount

let change amount =
  if amount < 0 then
    raise Negative_Amount
  else
    let denominations = [25; 10; 5; 1] in
    let rec aux remaining denominations =
      match denominations with
      | [] -> []
      | d :: ds -> (remaining / d) :: aux (remaining mod d) ds
    in
    aux amount denominations

(* Write your first then apply function here *)
let rec first_then_apply lst p f =
  match lst with
  | [] -> None
  | x :: xs -> if p x then f x else first_then_apply xs p f

(* Write your powers generator here *)
let powers_generator x =
  let rec generate_power n () =
    Seq.Cons (n, generate_power (n * x))
  in
  generate_power 1

(* Write your line count function here *)
let meaningful_line_count filename =
  let in_channel = open_in filename in
  Fun.protect
    ~finally:(fun () -> close_in in_channel)
    (fun () ->
      let rec count_lines acc =
        match input_line in_channel with
        | line ->
            let trimmed = String.trim line in
            if trimmed = "" || (String.length trimmed > 0 && trimmed.[0] = '#') then
              count_lines acc
            else
              count_lines (acc + 1)
        | exception End_of_file -> acc
      in
      count_lines 0)

(* Write your shape type and associated functions here *)
let pi = 4.0 *. atan 1.0

type shape =
  | Sphere of float
  | Box of float * float * float

let volume s =
  match s with
  | Sphere r -> (4.0 /. 3.0) *. pi *. (r ** 3.0)
  | Box (l, w, h) -> l *. w *. h

let surface_area s =
  match s with
  | Sphere r -> 4.0 *. pi *. (r ** 2.0)
  | Box (l, w, h) -> 2.0 *. (l *. w +. w *. h +. h *. l)
  
(* Write your binary search tree implementation here *)
type 'a bst =
  | Empty
  | Node of 'a bst * 'a * 'a bst

let rec insert (x : 'a) (tree : 'a bst) : 'a bst =
  match tree with
  | Empty -> Node (Empty, x, Empty)
  | Node (left, value, right) ->
      if x < value then
        Node (insert x left, value, right)
      else if x > value then
        Node (left, value, insert x right)
      else
        tree

let rec contains (x : 'a) (tree : 'a bst) : bool =
  match tree with
  | Empty -> false
  | Node (left, value, right) ->
      if x = value then true
      else if x < value then contains x left
      else contains x right

let rec size (tree : 'a bst) : int =
  match tree with
  | Empty -> 0
  | Node (left, _, right) -> 1 + size left + size right

let rec inorder (tree : 'a bst) : 'a list =
  match tree with
  | Empty -> []
  | Node (left, value, right) -> inorder left @ [value] @ inorder right