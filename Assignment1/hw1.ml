(*Test variables and functions
let firstTestList = [2;3;4;5;6;6;6;5;5;3;2];;
let secondTestList = [2;5;2;2;2;2;9;9;9;9];;
let thirdTestList= ["a";"b";"c";"d"];;

let fourthTestList= ["a";"2";"c";"4"];;

let fifthTestList = ["a";"2";"c";"4";"5"];;

let sixthTestList = [3];;

let seventhTestList = [2];;

let eigthTestList = [5;10;9;18;2;20;15];;

let ninthTestList = [5;22;29;3;9;21;20]

let firstTupleList = [2,3;9,2;3,0];;

let secondTupleList = [3,2;2,1;3,0];;
let thirdTupleList = [3,2;2,1;3,0;3,0;3,2];;

let evenTest n = (n= n / 2  * 2);;

let greaterThanTwenty n = n>20;;

let equivTestOne x y = (x mod 2) = (y mod 2);;

let mine = [firstTestList;secondTestList];;
*)

(*Problem #1*)

(*Helper function for compress*)
let rec compressHelp lst ch = match lst with
|hd::tl -> if hd =  ch then compressHelp (tl) ch 

  else hd:: (compressHelp (tl) (hd))

| _ -> [];;

(*Remove identical elements adjacent to eachother*)
let compress lst = if lst = [] then lst else let head = List.hd lst in head ::(compressHelp lst ((head)));;

(*Tests

compress thirdTupleList;;
- : (int * int) list = [(3, 2); (2, 1); (3, 0); (3, 2)]
─( 12:02:54 )─< command 7 >───────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # compress secondTestList;;
- : int list = [2; 5; 2; 9]
─( 12:03:02 )─< command 8 >───────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # compress firstTestList;;
- : int list = [2; 3; 4; 5; 6; 5; 3; 2]*)





(*Problem #2*)

(*Take a list and a function, create a list that that contains all true elements of f*)
let rec remove_if lst f = match lst with
|hd::tl -> if (f hd) then (*Check if the element passes the predicate*)

  remove_if tl f (*If it does, continue as usual*)
  else hd::( remove_if tl f)(*If it doesn't, add to the list*)

|_ -> [];;
(*
Expected: remove_if firstTestList evenTest;;
- : int list = [3; 5; 5; 5; 3]

Actual: remove_if firstTestList evenTest;;
- : int list = [3; 5; 5; 5; 3]

Expected: 
remove_if ninthTestList greaterThanTwenty;;
- : int list = [5; 3; 9; 20]

Actual:
remove_if ninthTestList greaterThanTwenty;;
- : int list = [5; 3; 9; 20]


Expected:
remove_if secondTestList evenTest;;
- : int list = [5; 9; 9; 9; 9]

Actual:
remove_if secondTestList evenTest;;
- : int list = [5; 9; 9; 9; 9]
*)


(*Problem #3*)

let rec slice lst i j = match lst with
|hd::tl -> if i = 0 then (*Check slice initial index to see if it starts*)
   
    (if j <= i then [] (*Check second split element*) (*If it is less than i, the split is no longer valid, return the array*)


    else hd::slice tl (i) (j-1))  (*Continue split with elements of the list, add elements in "split range"*)


  else slice tl (i-1) (j-1) (*Splitting has not started, decrement split indices*)



|_ -> [];;


(*
Expected:
slice slice fifthTestList 2 4;;
- : string list = ["c"; "4"]
Actual:
slice slice fifthTestList 2 4;;
- : string list = ["c"; "4"]

Expected:
slice fifthTestList 2 20;;
- : string list = ["c"; "4"; "5"]

Actual:
slice fifthTestList 2 20;;
- : string list = ["c"; "4"; "5"]

Expected:
slice fifthTestList 4 10;;
- : string list = ["5"]
Actual:
slice fifthTestList 4 10;;
- : string list = ["5"]

Expected:
slice fifthTestList 9 20;;
- : string list = []

Actual:
slice fifthTestList 9 20;;
- : string list = []

Expected:
slice fourthTestList 1 3;;
- : string list = ["2"; "c"]
Actual:
slice fourthTestList 1 3;;
- : string list = ["2"; "c"]

*)













(*Problem 4*)
(*Helper for equivs, check the built list for an equivalent match, return list list with added element in relevant section*)
  let rec equivalenceContainment f add finalLst = 
    match add with 
      |[] -> finalLst (*Empty lists are checked for base case*)
      |x::_ -> match finalLst with
        |[] -> [add]
        |hd::tl -> if f x (List.hd hd) then (hd @ add ) :: tl (*Looking at head, can add to head and return the finalLst*)
          else hd :: equivalenceContainment f add tl;; (*Continue with loop*)

  (*Separates list into list list based on equivalence on function f*)
  let equivs f lst = 
    let rec equivHelper f finalLst lst = match lst with
      | [] -> finalLst (*Finished group combining*)
      | [a] -> (equivalenceContainment f [a] finalLst) (*End of the list*)
      | a::b::tl -> 
          if f a b then 
            equivHelper f (equivalenceContainment f [a;b] finalLst) tl (*If two are equivalent, combine, add to finalList, and continue*)
          else (*If two aren't equivalent, add each one by one to finalList and continue*)
            equivHelper f (equivalenceContainment f [b] (equivalenceContainment f [a] finalLst)) tl 
    in 
    equivHelper f [] lst;; (*Base input for equivs*)

(*Expected: 
equivs equivTestOne [5;4;3;2;6;20;50;100;101];;
- : int list list = [[5; 3; 101]; [4; 2; 6; 20; 50; 100]]
Actual:
equivs equivTestOne [5;4;3;2;6;20;50;100;101];;
- : int list list = [[5; 3; 101]; [4; 2; 6; 20; 50; 100]]

Expected:
equivs (=) secondTestList;;
- : int list list = [[2; 2; 2; 2; 2]; [5]; [9; 9; 9; 9]]

Actual: 
equivs (=) secondTestList;;
- : int list list = [[2; 2; 2; 2; 2]; [5]; [9; 9; 9; 9]]
*)






(*Problemn #5*)

(*Check if number is prime, false if it gets divided, true if it reaches div = 1*)
let primeChecker num = let rec primeHelp num div = 
  if num <= 1 then false
  else if div = num -1 then
    true
  else if (num - (num/div * div)  = 0) then false (*Check modulo 0, if so, it divides, false*)
  else  
    primeHelp num (div +1) 
  in primeHelp num 2;; (*Increase divisor, if reached num - 1 then it is a prime*)




let rec goldBachHelper n x = (*Check case 0,1,2,3 first, then use prime starting to generate other numbers*)
if x > (n/2) then (0,0)  (*Check if x has went over midway point, checking rest is redundant*) 
else
  (if primeChecker x && primeChecker (n-x) then (x,n-x) else goldBachHelper n (x+1));;
  (*Use prime starting to find a number *)

let goldbachpair n = if n > 3 && (n - (n/2) * 2 = 0) then goldBachHelper n 2 (*Even number greater than 2*)
    else (0,0) (*Result is automatically invalid*);;

(*
Expected:
goldbachpair 18;;
- : int * int = (5, 13)

Actual:
goldbachpair 18;;
- : int * int = (5, 13)

Expected:
goldbachpair 30;;
- : int * int = (7, 23)

Actual:
goldbachpair 30;;
- : int * int = (7, 23)

Expected:
goldbachpair 18;;
- : int * int = (5, 13)

Actual:
goldbachpair 18;;
- : int * int = (5, 13)
*)


(*Problem #6*)
(*Take two functions and check for every element of the list that they are equivalent*)
let rec identical_on f g lst = match lst with 
|hd::tl ->if (f hd = g hd) then identical_on f g tl else false
|_->true;;

(*utop # let g i = i*2;;
val g : int -> int = <fun>
utop # let f i = i*i;;
val f : int -> int = <fun>
─( 10:43:56 )─< command 45 >─────────────────────────────────────────────────────────────{ counter: 0 }─
utop # identical_on f g sixthTestList;;
- : bool = false
─( 10:45:32 )─< command 46 >─────────────────────────────────────────────────────────────{ counter: 0 }─
utop # identical_on f g seventhTestList;;
- : bool = true
identical_on greaterThanTwenty evenTest [40;60;80];;
- : bool = true

*)



(*Problem #7*)

(*Compare two elements from a list and store some elements*)
(*Elements are stored by lst and filtered through cmp*)
let rec pairWiseFilter cmp lst = match lst with

  |x::y::tl -> (cmp x y) :: pairWiseFilter cmp tl (*Add valid element to list*)

  |[x] -> [x] (*Only one element left, "leave as is"*)

  |_-> [];; (*Empty case*)


(*utop # pairWiseFilter min firstTestList;;
- : int list = [2; 4; 6; 5; 3; 2]

pairWiseFilter max eigthTestList;;
- : int list = [10; 18; 20; 15]

pairWiseFilter max secondTestList;;
- : int list = [5; 2; 2; 9; 9]

*)


(*Problem #8*)

(*Helper function for problem 8, power function. Num to power of iterate*)
let rec power num iterate = if iterate = 0 then 1 
  else (if iterate = 1 then num else
    (num * power num (iterate -1)));;


(*Take a list of tuples and return the polynomial function corresponding with it*)
let rec polynomial lst x = match lst with 
|(a,b)::tl -> (power x b) * a + polynomial tl x
|_ -> 0;;


(*let tupOne =polynomial firstTupleList
;;
val tupOne : int -> int = <fun>
─( 10:00:15 )─< command 4 >───────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # tupOne 0;;
- : int = 3
─( 10:00:55 )─< command 5 >───────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # tupOne 1;;
- : int = 14
─( 10:01:02 )─< command 6 >───────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # tupOne 2;;
- : int = 55
utop # tupOne (-1);;
- : int = 10
─( 10:01:32 )─< command 10 >──────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # tupOne (-2);;
- : int = 23
─( 10:01:36 )─< command 11 >──────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # tupOne 3;;
- : int = 138
─( 10:01:41 )─< command 12 >──────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # let tupTwo = polynomial secondTupleList;;
val tupTwo : int -> int = <fun>
─( 10:02:09 )─< command 14 >──────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # tupTwo 2;;
- : int = 19
─( 10:02:17 )─< command 15 >──────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # tupTwo 0;;
- : int = 3
─( 10:02:46 )─< command 17 >──────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # tupTwo (-2);;
- : int = 11
─( 10:02:51 )─< command 18 >──────────────────────────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # tupTwo 3;;
- : int = 36*)




(*Problem #9*)

(*Helper method for suffixes*)
let rec s lst = match lst with
|_::[]-> [] (*Base case for empty tail*)
|_::tl-> tl:: s tl (*Keep adding suffixes while tail isn't empty*)
|_-> [];; (*Empty list case*)


(*Make a list of all the suffixes provided in list*)
let suffixes lst = if (lst = []) then [] else lst:: s lst;; (*Utilize base case, append initial to list*)


(*
suffixes fourthTestList;;
- : string list list =
[["a"; "2"; "c"; "4"]; ["2"; "c"; "4"]; ["c"; "4"]; ["4"]]
suffixes thirdTestList;;
- : string list list =
[["a"; "b"; "c"; "d"]; ["b"; "c"; "d"]; ["c"; "d"]; ["d"]]
suffixes firstTupleList;;
- : (int * int) list list =
[[(2, 3); (9, 2); (3, 0)]; [(9, 2); (3, 0)]; [(3, 0)]]
suffixes secondTupleList;;
- : (int * int) list list =
[[(3, 2); (2, 1); (3, 0)]; [(2, 1); (3, 0)]; [(3, 0)]]


*)


(*Problem #10*)
(*
add- the current element that is being added
rest- list list, stores collection that add needs to combine with (map to)
*)
let rec powersetHelper add rest =
  match rest with
  | hd::tl -> (add :: hd) :: powersetHelper add tl (*Keep mapping add to the elements of the list*)
  | _ -> [];; (*Base case*)

(*Make a powerset of a list, return 'a list list*)
let rec powerset lst =
  match lst with
    | hd::tl -> let sets = powerset tl in 
      sets @ powersetHelper hd (sets) (*Start at last element, build combinations from there, merge recurisvely with already computed sets*)
    |_ -> [[]];;(*Base case*)


(*Expected:
powerset thirdTestList;;
- : string list list =
[[]; ["d"]; ["c"]; ["c"; "d"]; ["b"]; ["b"; "d"]; ["b"; "c"]; ["b"; "c"; "d"];
 ["a"]; ["a"; "d"]; ["a"; "c"]; ["a"; "c"; "d"]; ["a"; "b"]; ["a"; "b"; "d"];
 ["a"; "b"; "c"]; ["a"; "b"; "c"; "d"]]

 Actual: 
 powerset thirdTestList;;
- : string list list =
[[]; ["d"]; ["c"]; ["c"; "d"]; ["b"]; ["b"; "d"]; ["b"; "c"]; ["b"; "c"; "d"];
 ["a"]; ["a"; "d"]; ["a"; "c"]; ["a"; "c"; "d"]; ["a"; "b"]; ["a"; "b"; "d"];
 ["a"; "b"; "c"]; ["a"; "b"; "c"; "d"]]

Expected: powerset firstTupleList;;
- : (int * int) list list =
[[]; [(3, 0)]; [(9, 2)]; [(9, 2); (3, 0)]; [(2, 3)]; [(2, 3); (3, 0)];
 [(2, 3); (9, 2)]; [(2, 3); (9, 2); (3, 0)]]

 Actual: powerset firstTupleList;;
- : (int * int) list list =
[[]; [(3, 0)]; [(9, 2)]; [(9, 2); (3, 0)]; [(2, 3)]; [(2, 3); (3, 0)];
 [(2, 3); (9, 2)]; [(2, 3); (9, 2); (3, 0)]]

 *)







