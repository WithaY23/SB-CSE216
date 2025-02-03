(*CREATED TYPES
binary tree
type 'a binarytree = 
|Leaf
|NodeB of 'a * 'a binarytree * 'a binarytree;;

arithmetic tree
type ('a,'b) tree =
|Leaf of 'a
|Tree of ('a, 'b) node

and

('a,'b) node = {
operator: 'b;
left: ('a,'b) tree;
right: ('a,'b) tree
};;



rattorand

type ratorrand = (*Used to distinguish what list to form*)
|Operator
|Operands
;; 


return
type ('a,'b)return = 
|First of 'a
|Second of 'b


operator
type operator =
|Addition
|Subtraction
|Multiplication
|Division 



valid
type valid = 
|LeftParentheses
|RightParentheses
|Addition
|Subtraction
|Multiplication
|Division
|Int
|Float
|Dot
|Space


expression
type expr =
| Const of int
| Var of string
| Add of expr * expr
| Mul of expr * expr;;


*)


(*Problem #1*)
(*In order, display a binary tree -> int list*)
(*Can be expanded to 'a list, required int for hw*)

(*Binary tree format*)
type 'a binarytree = 
|Leaf
|NodeB of 'a * 'a binarytree * 'a binarytree;;

(*Generic reverse a list, lst*)
let rec reverse lst = match lst with
|hd::tl -> reverse tl @ [hd]
|_-> [];;

(*Walk in order algorithm*)

let walk_inorder (y: 'a binarytree):int list = let rec inOrderHelper (x:'a binarytree):int list = match x with
|Leaf -> [] (*Base case for recursion*)
|NodeB (n,ltree,rtree) -> (inOrderHelper rtree) @ (n :: inOrderHelper ltree )(*Add node to tree, evaluate left and right, append left after, right before*)
in reverse (inOrderHelper y);; (*Reverse the lst*)

(*Test cases*)
let myBinaryTree = NodeB(1,NodeB(2,NodeB(4,Leaf,Leaf),NodeB(5,Leaf,Leaf)),NodeB(3,NodeB(9,Leaf,Leaf),NodeB(0,Leaf,Leaf)));;

walk_inorder myBinaryTree;;

let yourBT = NodeB(1,NodeB(2,Leaf,NodeB(3,Leaf,Leaf)),Leaf);;

walk_inorder yourBT;;


(*Problem #2*)
(*Print a list based on an arithmetic tree depending on the specified value Operators or Operands*)

(*Arithmetic tree definition*)
type ('a,'b) tree =
|Leaf of 'a
|Tree of ('a, 'b) node

and

('a,'b) node = {
operator: 'b;
left: ('a,'b) tree;
right: ('a,'b) tree
};;


(* let x = (Leaf 2);; *)




type value = (*Used to distinguish what list to form*)
|Operators
|Operands
;; 

type operator = (*Actual types of operators*)
|Addition
|Subtraction
|Multiplication
|Division 


let b = 
    {
        operator  = Addition;

        left = Tree
                {
                operator = Subtraction;
                left = Tree
                {
                    operator = Division;
                    left = Leaf 1;
                    right = Leaf 2;


                };
                right = Tree
                {
                    operator = Multiplication;
                    left = Leaf 12;
                    right = Leaf 10;

                }
                };



        right = Leaf 4
    };;


let a = Tree b;;

type ('a,'b)return = 
|Operand of 'a
|Operator of 'b


(*Piazza @111 stated that ensuring type operators merely meant that I didn't have to worry about other cases other than the 4 operators*)
let rec items_of_parameter_type (y:('a, 'b) tree) (v:value) = match v with 

    |Operators -> (let rec operatorTree (t:('a, 'b) tree) = (match t with
        |Tree {operator = o;left = l;right = r} -> (operatorTree r) @ (Operator(o):: operatorTree l)
        |Leaf _-> []) in reverse (operatorTree y))

    |Operands -> (let rec operandTree (t:('a, 'b) tree)  = (match t with
        |Tree {operator = o;left = l;right = r} -> (operandTree r) @ (operandTree l)
        |Leaf l -> [Operand(l)]) in reverse (operandTree y));;





(* in myX item tree *)

(*(let rec operandTree (t:('a, 'b) tree) :'a list = (match t with
    |Tree {operator;left;right} -> (operandTree right) @ (operandTree left)
    |Leaf l -> [l]) in operandTree y);;*)

    (*** Type of  operatorTree is ('a, 'a) tree -> 'a list*)
(**)


(*Problem 3*)
(*Take a fully parenthesized expression as a string and display it in an arithmetic tree format*)



(*Only left parentheses may start a string and right parentheses end*)

(*Use operator as defined before*)
let myO = Addition


(*Use tree definition from before*)
let x = (Leaf 2);;
let c = Tree
    {
        operator  = "5";

        left = Tree
            {
                operator = "6";
                left = Leaf 3;
                right = Tree
                {
                    operator = "10";
                    left = Leaf 12;
                    right = Leaf 10;

                }
            };



        right = Leaf 4
    };






type valid = 
|LeftParentheses
|RightParentheses
|Add
|Subtract
|Multiply
|Divide
|Int
|Float
|Dot
|Space

(*Alredy have type operator defined*)
let mine (x:operator) = 2;;

(*Helper functions*)
let isDigit a :bool= match a with
|'0' -> true
|'1' -> true
|'2' -> true
|'3' -> true
|'4' -> true
|'5' -> true
|'6' -> true
|'7' -> true
|'8' -> true
|'9' -> true
|_-> false;;




let isSpace a :bool = match a with
|' ' -> true
|_ -> false;;

let isOperator a :bool = match a with
|'+' -> true
|'-' -> true
|'*' -> true
|'/' -> true
|_ -> false;;



(*Possible error values, multiple for testing*)

exception InvalidInput;;
exception EndErrorInput;;
exception OddError;;
exception DotInParserHelper;;
exception SpaceInParserHelper;;

(*Parse all the possible inputs*)
let parser str = (*Was str lst, removed and replaced with an empty list*)
    (*All elements of the list will be a 2d list, [[e]; [1;2;3;.;4];[+;.]]*)
    let rec parserHelper str lst index max =

        if (index = max) then (*If the index is at the last character, must be at the end*)
            if (str.[index] = ')') then (*Redundant check, already ensured ) was at the end*)
                reverse ([str.[index]]::lst)
            else raise EndErrorInput

        else if(isDigit (str.[index])) then (
            digitParser str (lst) [] (index) max false
            ) 
        else if((str.[index] = '-')) then ( (*account for negative values*)
            if (index+ 1 < max) 
                then if (isDigit (str.[index+1])) then (*negatives have to have a digit after*)
                    digitParser str (lst) [str.[index]] (index + 1) max false (*Add negative as first input*)
                    else operatorParser str lst [] index max (*Assume operator subtraction and send for its parser to handle*)

                else operatorParser str lst [] index max )

        else if (isOperator (str.[index])) then
            operatorParser str lst [] (index) max
        
        else if (str.[index] = '(') then
            leftParenthesesParser str lst (index) max

        else if (str.[index] = ')') then
            rightParenthesesParser str lst (index) max
        else if (str.[index] = ' ' ) then
            raise SpaceInParserHelper
        else if (str.[index] = '.' ) then
            raise DotInParserHelper
        else raise InvalidInput (*Changed*)
        (*Changed index+1 to index at parsers, should account for leftP and rightP more thoroughly*)

        (*
                *)
        (*dot is flag for dot, false if not checked yet*)
        (*DigitParser, take a string and create a list containing the relevant digit.*)
        (*Use originalList to keep track of what the original parser held*)
        (*Use newLst to add new elements*)
        (*Includes processing float*)
        (*When morphing list, use String.concat to get digits inline*)
        (*Then use int_of_string/ float_of_string to get digits to value*)
    and digitParser str originalLst newLst index max dot = if (index = (max+1))   (*Check if the next input will cause an error*)
        then raise InvalidInput (*Raise an error*)
        
        else if(str.[index] = '.') then (*Check if the next thing is a valid dot, check if dot has already been added*)
            (if not dot then 
                (digitParser str originalLst (str.[index] ::newLst) (index+1) max true) (*Check if dot has been flagged, parse rest of digit*) (*MAKE FLOAT CONVERSION HERE*)
            else raise InvalidInput) (*Flag if multiple decimals in one line*)
        else if (isDigit (str.[index])) then 
            digitParser str originalLst (str.[index] ::newLst) (index+1) max dot (*Digit case*)
        else if(isSpace (str.[index])) then (*Ensure that the next element is a valid value, end the parsing of digit*)
            
            (*Must be an operator, right parentheses,"peek" at the next value*)
            if (index = max) then 
                raise InvalidInput (*If space is the last value, its invalid*)
            else (if (str.[index+1] = ')') 
                then  parserHelper str ((reverse (newLst)) :: originalLst) (index+1) max (*end of the string, skip space and keep parentheses for parsing*)
            else if (isOperator (str.[index+1])) 
                 then parserHelper str  (( reverse newLst) :: originalLst) (index+1) max (*skip space, keep operator *)
            else raise InvalidInput (*must be an operator or a closing parentheses*)
            )
            
             (*Finished number, add to list*)
        else if(str.[index] = ')') then parserHelper str ((reverse newLst)::originalLst) index max  (*Finished number, keep parentheses for parsing*)
        
        
        else raise InvalidInput(*invalid character*)
            
            (*parserHelper str lst index max  (*No dot, make cases for digit, parentheses, and space. Other input is invalid*)*)
    and operatorParser str originalLst newLst index max = 
        if (index + 2 = max) then (* Needs to process several more inputs after operator, raise error if it can't *)
            raise InvalidInput
        else if (isOperator (str.[index])) then (* Validate operator, check character after *)
            if (str.[index + 1] = ' ') then (* Validate that there is a number or expression after operator *)
                if (isDigit str.[index + 2]) then 
                    parserHelper str ([str.[index]]::originalLst) (index + 2) max (*Skip space and send parse*)

                else if (str.[index + 2] = '(') then 
                    parserHelper str ([str.[index]]::originalLst) (index + 2) max
                else if((str.[index+2] = '-')) then ( (*account for negative values*)
                    if (index+ 3 < max) 
                        then if (isDigit (str.[index+3])) then
                            parserHelper str ([str.[index]]::originalLst) (index + 2) max
                            else raise InvalidInput
        
                        else raise InvalidInput )
                else 
                    raise InvalidInput 
            else if (str.[index + 1] = '.') then 
                if (index + 3 = max) then (*Has a dot, set a new max value*)
                    raise InvalidInput 
                else if (str.[index + 2] = ' ') then  (*Process similar to without dot*)
                    if (isDigit str.[index + 3]) then 
                        parserHelper str ([str.[index]; str.[index + 1]]::originalLst) (index + 3) max

                    else if((str.[index+3] = '-')) then ( (*account for negative values*)
                        if (index+ 4 < max) 
                            then if (isDigit (str.[index+4])) then
                                parserHelper str ([str.[index]; str.[index + 1]]::originalLst) (index + 3) max
                                else raise InvalidInput
            
                            else raise InvalidInput )
                    else if (str.[index + 3] = '(') then 
                        parserHelper str ([str.[index]; str.[index + 1]]::originalLst) (index + 3) max
                    else 
                        raise InvalidInput
                else 
                    raise InvalidInput
            else 
                raise InvalidInput
        else 
            raise InvalidInput 
    (*Links to space, digit, left/right parentheses*)
    and leftParenthesesParser str lst index max = 
        if(index = max) then
            raise InvalidInput
        else if (str.[index] = '(') then
            if(str.[index+1] = ')') then (*Check valid input after parentheses*)
                parserHelper str ([str.[index]] :: lst) (index +1) max

            else if(str.[index+1] = '(') then 
                parserHelper str ([str.[index]] :: lst) (index +1) max

            else if(isSpace str.[index+1]) then 
                parserHelper str ([str.[index]] :: lst) (index +2) max

            else if(isDigit str.[index+1]) then 
                parserHelper str ([str.[index]] :: lst) (index +1) max
            
            else if((str.[index+1] = '-')) then ( (*account for negative values*)
                if (index+ 2 < max) 
                    then if (isDigit (str.[index+2])) then
                        parserHelper str ([str.[index]]::lst) (index + 1) max
                        else raise InvalidInput
    
                    else raise InvalidInput )

            else raise InvalidInput (*Changed*)

        else
            raise InvalidInput (*Not necessary, input should already be '('*)

    and rightParenthesesParser str lst index max = (*CREATE an if index = max+1 end case in parserHelper, did it*)
        (* if(index = max) then 
            parserHelper str ([str.[index]]::lst) (index+1) max Reached end of the string *)
        if (index+1 = max) then 
            if(str.[index+1] = ')') then (*If it's just an end parentheses, add right parentheses*)
                parserHelper str ([str.[index]]::lst) (index+1) max
            else raise InvalidInput
        else if (str.[index] = ')') then
            if(str.[index+1] = ' ') then (*Skip the space*)


                if(index+2 <= max) then
                    if(str.[index+2] = ')') then 
                        parserHelper str ([str.[index]]::lst) (index+2) max

                    else if(isOperator str.[index+2]) then
                        parserHelper str ([str.[index]]::lst) (index+2) max
                    else raise InvalidInput

                
                else raise InvalidInput
            else if (str.[index+1] = ')') then
                parserHelper str ([str.[index]]::lst) (index+1) max
            else
                raise InvalidInput
            
        else raise InvalidInput

                    
        
             
    

        
                    
in parserHelper str [] 0 (String.length(str)-1);; (*Check max (changed in digitparser to max+1), currently set to String length *)


(*Continued helper functions and datatypes*)
(*Ensure valid count of parentheses*)


(*type operator = (*Actual types of operators*)
|Addition
|Subtraction
|Multiplication
|Division 
*)

type fint = 
|Int of int
|Float of float

let convertIOperator o = match o with
| "+" -> Addition
| "-" -> Subtraction
| "*" -> Multiplication
| "/" -> Division
|_ -> raise InvalidInput;;


(*Float operators for buildtree helpers*)
type floatOperators = 
|Faddition
|Fsubtraction
|Fmultiplication
|Fdivision 

let convertFOperator o = match o with
| "+." -> Faddition
| "-." -> Fsubtraction
| "*." -> Fmultiplication
| "/." -> Fdivision
|_ -> raise InvalidInput;;

type validOperators = 
|IntOperator of operator
|FloatOperator of floatOperators;;


(* let a (x:validOperators) = match x with
|IntOperator y-> (match y with
    |Addition -> 1
    |Subtraction -> 2
    |Multiplication -> 3
    |Division -> 4
)
|FloatOperator _-> 3;; *)



let rec counting lst char = match lst with
|hd::tl -> (if (hd =char) then 1 else 0) + counting tl char
|_-> 0;;

(*Take char list into a string*)
let char_concat chars =
    List.fold_left (fun acc c -> acc ^ String.make 1 c) "" chars

(*Make char list list into string list*)
let rec rConcatentation originalLst = match originalLst with
|hd::tl -> (char_concat hd) :: (rConcatentation tl)
|_->[];;


(*Check first operators type, if it is a float or integer operator*)
let rec findOperator lst = match lst with 
|hd::tl-> if(isOperator hd.[0]) then 
            if (String.length hd = 2) then
                if (isDigit hd.[1]) then findOperator tl else (*Account for negative*)
                FloatOperator (convertFOperator hd)
            else IntOperator (convertIOperator hd)
          else findOperator tl
        
|_ -> raise OddError;;

let rec findIfOperator lst = match lst with 
|hd::tl-> if(isOperator hd.[0]) then 
            if (String.length hd >= 2) then
                if (isDigit hd.[1]) then findIfOperator tl else (*Account for negative*)
                true
            else true
          else findIfOperator tl
        
|_ -> false





(*let testVar = findOperator ["55555" ; "+." ; "2.9"];;
let testMatch (x:validOperators) = match x with
|IntOperator _ -> 2
|FloatOperator _-> 3;;*)



(*if(isOperator (List.hd hd)) then (*Check if all the operators are homogeneous under float and integer operations*)
                        2
                    else raise InvalidInput*)

let rec validateOperators (t:validOperators) lst = match lst with 
|hd::tl -> 
    if (isOperator hd.[0]) then (
        if (String.length hd > 1) then 
            if (isDigit hd.[1]) then  (*Negative number*)
                validateOperators t tl  (*Continue with the rest of the list *)
            else 
                match t with
                |IntOperator _ -> if (String.length hd = 1) then validateOperators t tl else false
                |FloatOperator _ -> if (String.length hd = 2) then validateOperators t tl else false
        else 
            match t with
            |IntOperator _ -> if (String.length hd = 1) then validateOperators t tl else false
            |FloatOperator _ -> if (String.length hd = 2) then validateOperators t tl else false
    )
    else 
        validateOperators t tl  (*Continue with rest *)
| _ -> true 
(*Create a special check for IntOperator, ensure all are ints*)
let rec validateInts lst = match lst with 
|hd::tl -> if (isDigit hd.[0]) then 
                if(String.contains hd '.')  
                    then false
                    else validateInts tl
            else if (String.length hd >=2) then 
                (if (isOperator hd.[0]) then (*Account for negative*)
                    if(isDigit hd.[1]) then
                        if(String.contains hd '.')  
                            then false
                        else 
                            validateInts tl
                    else validateInts tl
                else validateInts tl )
            else validateInts tl
|_-> true;;

let rec findInt lst : fint = match lst with 
|hd::tl -> 
    if (hd.[0] = '-') then  (*check for negative numbers *)
        if (String.length hd >= 2) then(
            if (isDigit hd.[1]) then 
                if (validateInts lst) then 
                    Int(int_of_string hd) 
                else
                    Float(float_of_string hd)
            else 
                findInt tl)
            else findInt tl
    else if (isDigit hd.[0]) then
        if (validateInts lst) then 
            Int(int_of_string hd)
        else
            Float(float_of_string hd)
    else 
        findInt tl 
| _ -> raise OddError;;

(* 

type ('a,'b) tree =
|Leaf of 'a
|Tree of ('a, 'b) node

and

('a,'b) node = {
operator: 'b;
left: ('a,'b) tree;
right: ('a,'b) tree
};; 


*)

(*Building the trees*)
let build_integer_tree (parsedString: string list) : (fint, validOperators) tree =
    let rec build_subtree lst : ((fint,validOperators) tree * string list)= match lst with
    | "(" :: tl ->  (* Start building a tree *)
        let (left, lRemaining) = build_subtree tl in  (* Process left subtree *)
        let operator = List.hd lRemaining in  (* Next element must be an operator *)
        let (right, rRemaining) = build_subtree (List.tl lRemaining) in  (* Process right subtree *)
        let _ = match List.hd rRemaining with
                | ")" -> List.tl rRemaining  (* Ensure the next element is a right parenthesis *)
                | _ -> raise InvalidInput
        in
        (* Return the cumulated tree and the remaining list *)
        (Tree { operator = (IntOperator (convertIOperator operator)); left = left; right = right }, List.tl rRemaining)  
    | hd :: tl -> (*Used for leaves*)
        if (String.length hd = 1) then(
            if isDigit hd.[0] then
            (Leaf (Int(int_of_string hd)), tl)
            else raise InvalidInput
            )  (* Return the leaf and the remaining list *)
        else if isOperator hd.[0] then(
            if (isDigit hd.[1]) then 
                (Leaf (Int(int_of_string hd)), tl)
            else raise InvalidInput )
        
        else if isDigit hd.[0] then 
            (Leaf (Int(int_of_string hd)), tl)

        else
            raise InvalidInput
    | _ -> raise InvalidInput

    in let (tree, remaining) = build_subtree parsedString in  (* Start processing the parsed string *)
    tree;;  (* Return the constructed tree *)

let build_float_tree (parsedString: string list) : (fint, validOperators) tree =
    let rec build_subtree lst : ((fint,validOperators) tree * string list)= match lst with
    | "(" :: tl ->  (* Start building a tree *)
        let (left, lRemaining) = build_subtree tl in  (* Process left subtree *)
        let operator = List.hd lRemaining in  (* Next element must be an operator *)
        let (right, rRemaining) = build_subtree (List.tl lRemaining) in  (* Process right subtree *)
        let _ = match List.hd rRemaining with
                | ")" -> List.tl rRemaining  (* Ensure the next element is a right parenthesis, needs to be as it is "closing" a subtree *)
                | _ -> raise InvalidInput
        in
        (* Return the cumulated tree and the remaining list *)
        (Tree { operator = FloatOperator(convertFOperator operator); left = left; right = right }, List.tl rRemaining)  
    | hd :: tl -> (*Used for leaves*)
        
        if (String.length hd = 1) then( (* Return the leaf and the remaining list *)
            if isDigit hd.[0] then
                (Leaf (Float(float_of_string hd)), tl)
            else raise InvalidInput
            )
        else if isOperator hd.[0] then(
            if (isDigit hd.[1]) then 
                (Leaf (Float(float_of_string hd)), tl)
            else raise InvalidInput )
        else if isDigit hd.[0] then
            (Leaf (Float(float_of_string hd)), tl)

        else
            raise InvalidInput
    | _ -> raise InvalidInput

    in let (tree, remaining) = build_subtree parsedString in  (* Start processing the parsed string *)
    tree;;  (* Return the constructed tree *)


(*Build the arithmetic tree, using created datatypes for polymorphism*)
let build_tree (y:string) : (fint, validOperators) tree = 

    if(y.[0] = '(' && y.[String.length y -1 ] = ')') then 
        let parsed = parser y in (*Parsed is char list list*)
            
             if (counting parsed ['('] = counting parsed [')'])  then (*Check valid parentheses count*)     
                let parsedString = rConcatentation parsed in (*make char list list into string list*)
                    if(findIfOperator parsedString) then(


                        let typeOfOperators = findOperator parsedString in (*Store float/int operator that is used, all operators must match*)
                            if(validateOperators typeOfOperators parsedString) then 
                                match typeOfOperators with
                                |IntOperator _-> if(validateInts parsedString) then build_integer_tree parsedString
                                    else raise InvalidInput (*Fail, all operands must be ints if operators are*)
                                        
                                |FloatOperator _-> build_float_tree parsedString (*Doesn't care about operands, will make them all float regardless*)
                                (* |NoOperators -> if(validateInts parsedString) then build_integer_tree parsedString
                                    else build_float_tree parsedString  Couldn't make it work with 0 operators *)
                            else (*operators don't match*)
                                raise InvalidInput)
                        else Leaf( findInt parsedString)

            else raise InvalidInput
     else raise InvalidInput;; 




(*Test case
build_tree "( (2 + 5) - (3 * (9 / 4) ) )";;
build_tree "( (2 + 5) - (3 * (9 / 4)))";;
build_tree "(((2 +. 9.) +. ( 5. /. 3.)) +. 9.)";;
build_tree "(((2 +. 9) +. ( 5 /. 3)) +. 9)";;

let t = build_tree "((1 +. 0.999) +. (0.001 *. +1))";;
Exception: InvalidInput.

let t = build_tree "((1 +. (-5. *. -3.)) +. 4)";;

*)


(*Problem 4*)
(*Evaluate valid arithmetic tree formed in problem 3*)
(*Return fInt, datatype of float or int*)


(*type operator =
|Addition
|Subtraction
|Multiplication
|Division 
*)


(* type floatOperators = 
|Faddition
|Fsubtraction
|Fmultiplication
|Fdivision  

type fint = 
|Int of int
|Float of float
*)
let rec evaluate(t:(fint,validOperators) tree) :fint = match t with
|Tree {operator = o; left = l; right = r} ->
    (
    let leftResult = evaluate l in  (*calculate left and right subtrees*)
    let rightResult = evaluate r in 
    match o with (*Distinguish between float and integer operations*)
    |FloatOperator f-> (let leftFloat = match leftResult with (*left and right result were stored as float/int values, get primitive values*)

        |Float x -> x 
        |_ -> raise InvalidInput in (*Redundant, is assured by buildtree to be a float*)

        let rightFloat = match rightResult with 
        |Float y -> y
        |_ -> raise InvalidInput in

    (match f with (*Match operator and calculate current tree/subtree*)
        |Faddition -> Float ((leftFloat) +. (rightFloat))
        |Fsubtraction -> Float (leftFloat -. rightFloat)
        |Fmultiplication -> Float (leftFloat *. rightFloat)
        |Fdivision -> if rightFloat = 0.0 then raise Division_by_zero  (*handle division by zero *)
            else Float (leftFloat /. rightFloat)))

    |IntOperator i-> (*similar to float*)
        let leftInt = match leftResult with 
        |Int x -> x
        |_ -> raise InvalidInput in 

        let rightInt = match rightResult with 
        |Int y -> y
        |_ -> raise InvalidInput in

        (match i with 
        |Addition -> Int ((leftInt) + (rightInt))
        |Subtraction-> Int((leftInt) - (rightInt))
        |Multiplication-> Int((leftInt) * (rightInt))
        |Division -> if rightInt = 0 then raise Division_by_zero 
        else Int((leftInt) / (rightInt)))
    )
|Leaf x -> x (*return just the leaf*)

(*
let t = build_tree "(((2 +. 9) +. ( 5 /. 3)) +. 9)";;
let v = evaluate t;; = Float 21.6666666...43

let t = build_tree "(1 + (2 * 3))";;
let v = evaluate t;;  = Int 7

let t = build_tree "((1.5 +. 2.0) *. 3.0)";;
let v = evaluate t;; = Float 10.5

let t = build_tree "(1 +. (2 *. 3))";;
let v = evaluate t;;  = Float 7.

let t = build_tree "((1 +. (-5. *. -3.)) +. 4)";;
let v = evaluate t;;  = Float 20.

let t = build_tree "((1 +. 0.999) +. (-0.001 *. -1))";;
let v = evaluate t;;  = Float 2.


let t = build_tree "(1 +. (2 /. 0))";;
let v = evaluate t;;  = Exception Division_by_zero



*)







(*Problem 5*)
(*Evaluate ADT arithmetic expression by reducing constants to lowest form*)

(* 2x+5y+5+10 *)
(* | -> Add( Add (Add (Mul (Const 2, Var "x"), Mul(Const 5, Var "y")), Const 5), Const 10)*)
type expr =
| Const of int
| Var of string
| Add of expr * expr
| Mul of expr * expr;;

(* let a = Const 2;;
let c = Const 3;;

let rec convertConst (e:expr) = match e with
|Const a-> a
|_-> 0;;

let rec convertVar (e:expr) = match e with
|Var a-> a
|_-> "";; *)

(*Theory cases:
Add 2 and x, add to 5. 2 and x are irreducible, but 2 needs to add to 5 = 7 + x  (Add (Add(2, x), 5))
Multiply 2 and x, add to 5. 2 and x must be irreducible and lead to 5 being irreducible = 2*x + 5 (Add (Mul(2, x), 5))

Essentially make multiply fields "private", innaccessible by outside interactions such as Add 5..
Make add "public", only constants are allowed to be used by outside interaction

2nd thought
Multiplication is similar to a map (x+2)(x+3)
    Apply all of the elements of expression 1 (e1) to e2.


*)




(*Constants will, if any, always be stored in the left slot, find what's stored in the left slot*)
let rec findBaseValue (e:expr) :expr = match e with
|Mul(a,_) -> findBaseValue a
|Add(a,_) -> findBaseValue a
|Var v -> Var v
|Const c -> Const (c) ;;

(*Take value to be simplified and constant value e2,*)
(*If base value is a var, entire thing needs to be wrapped in "Add()" and if it's a constant, it needs to be evaluated*)
    (*Use findBaseValue to make this distinction*)
(* let rec addBaseValue (e:expr) (c2:int) :expr = match e with
|Mul(a,b) -> Mul (addBaseValue a c2,b)
|Add(a,b) -> Add(addBaseValue a c2,b)
|Var v -> Var v
|Const c -> Const (c + c2) ;; *)

(*constants: multiplication = 2nd slot, addition = 1st slot*)
let rec addBaseValues (e1:expr) (e2:expr) :expr = match e1 with (*Addition version*)
|Mul(a,b) -> Mul ((addBaseValues a e2), b)
|Add(a,b) -> Add ((addBaseValues a e2), b)
|Var v1 -> Var v1 (*I check with findBaseValues first, shouldn't matter*)
|Const c1 -> (match e2 with 
    |Mul(a,b) -> Mul ((addBaseValues e1 a), b)
    |Add(a,b) -> Add ((addBaseValues e1 a), b)
    |Var v2 -> Var v2 (*Could do a Add(c1,v2) statement to preserve structure. I check with findBaseValues first, shouldn't matter*)
    |Const c2 -> Const (c1+c2) );;

let rec multiplyBaseValues (e1:expr) (e2:expr) :expr = match e1 with (*Multiplication version*)
|Mul(a,b) -> Mul (a, multiplyBaseValues b e2) 
|Add(a,b) -> Add ((multiplyBaseValues a e2), (multiplyBaseValues b e2)) (*Shouldn't I multiply it to every term?, do multiplyBaseValues to a and b?*)
|Var v1 -> Mul(Var v1, e2)
|Const c1 -> (match e2 with 
    |Mul(a,b) -> Mul ( a, (multiplyBaseValues e1 b))
    |Add(a,b) -> Add ((multiplyBaseValues e1 a), (multiplyBaseValues e1 b)) (*Multiply it to every term*)
    |Var v2 -> Mul(Var v2, Const c1)
    |Const c2 -> Const (c1*c2) );;


let rec reduce (e:expr) :expr= match e with
(*Absolute reducible multiplication cases*)
|Mul(l,r) -> let left = reduce l in 
    let right=  reduce r in
    (*Absolute reducible multiplication cases*)
    (match (left,right) with
    |(Const 1, wild) -> wild (*Same regardless*)
    |(wild, Const 1) -> wild
    (* |Mul(Const 1, Var v) -> Var v
    |Mul(Var v, Const 1) -> Var v *)
    |(Const c, Const a) -> Const (c * a) (*Multiply the constants*)

    (*Basic nonreducible cases*)
    |(Var v,Var a) -> Mul(Var v, Var a)
    |(Var v, Const c) -> Mul(Var v,Const c)
    |(Const c,Var v ) -> Mul(Var v,Const c) (*Move const to back, used in baseValue functions*) 
    (*DC, idea is in baseValue, it only checks left and returns that value, primarily(only?) for addition reasons.
    If its a constant multiplied to a constant, its irreducible and shouldn't be modified, signify this by Var in first slot
        Variables that are addable don't have to be added (Ex: 2x + 3x)
    *)

    (*Nested cases, Has an Mul/Add after*)
    (*Use recursion through the nested components*)
    (* |(Const c, Add(a,b)) ->convertR (Mul ((Const c),(convertR (Add(a,b))))) (*Computes the nested add, sends as an argument after*)
    |(Add(a,b), Const c) ->convertR (Mul ((Const c),(convertR (Add(a,b)))))
    |(Var v, Add(a,b)) -> convertR (Mul ((Var v),(convertR (Add(a,b)))))
    |(Add(a,b),Var v) -> convertR (Mul ((Var v),(convertR (Add(a,b)))))

    |(Const c, Mul(a,b)) ->convertR(Mul ((Const c),convertR(Mul (a,b))))
    |(Mul(a,b), Const c) ->convertR(Mul ((Const c),convertR(Mul (a,b))))
    |(Var v, Mul(a,b)) ->convertR(Mul ((Var v),convertR(Mul (a,b))))
    |(Mul(a,b), Var v) ->convertR (Mul ((Var v),(convertR (Mul(a,b))))) *)


    |(Var v, wild) -> Mul(Var v, wild) (*Prevent constant access from addition through having wild as second slot, multiplication = 2nd, addition = 1st*)
    |(wild, Var v) -> Mul(Var v, wild)

    (*It shouldn't matter what the basevalue is, distribute to every term*)
    |(Const c, wild) -> multiplyBaseValues (Const c) wild
    |(wild, Const c) -> multiplyBaseValues (Const c) wild

    |(a,b) -> multiplyBaseValues a b

    

    (*Mul (a,Add (b,c)) -> convertAdd (Add(convertMul (Mul(a,b)),convertR (Mul(a,c)))) *) (*This should be the code for multiplying nested*)
    (*Mul (a,Mul(b,c)) -> convertMul (Mul (convertMul (Mul(a,b)), convertMul (Mul(a,c)))) *) 
    
    (*Do I need convertMul surrounding? Might lead to infinite loop*)
        (*I shouldn't, if it could've converted, it should've done so already and the two are irreducible*)
        (*Combine the inner first and then distribute the multiplication, 
            won't need to convert after multiplying as if it weren't compatible before, it won't be now*)
    
    
    (*Crazy idea, pattern matching.
        Set the result to be a variable, let x = inner conversion of left and righ
        match x with the type that x turns out to be
        if const, keep const
        if var, keep var
        if other, add Mul to it and send up

        New pattern matching
        Add cases
        set result of left to l, right to r
        match l
            match r
                if l is a variable
                    Add l r
                if l is Add
                    if r is constant
                        Add to first ( ,) slot
                    if r is Add
                        Add to first ( ,) slot
                    

                if l is a constant


        
        *)
    
    (* |_,_ -> raise InputError *)
    )
|Add(l,r) -> let left = reduce l in 
        let right=  reduce r in
        (*Absolute reducible addition cases*)
        (match (left,right) with
        |(Const 0, wild) -> wild (*Same regardless*)
        |(wild, Const 0) -> wild
        (* |Mul(Const 1, Var v) -> Var v
        |Mul(Var v, Const 1) -> Var v *)
        |(Const c, Const a) -> Const (c + a) (*Add the constants*)


        (*Nonreducible basic addition cases*)
        (*Add variable to anything, move other to the front*)
        |(Var v, wild) -> Add(wild, Var v)
        |(wild,Var v) -> Add(wild,Var v)

        (* |(Var v, Const c) -> Add(Const c, Var v)Move const to front, used in baseValue functions to represent addable *)

        
        

        (*Nested cases, Has an Mul/Add after*)
        |(Const c, wild) -> (match (findBaseValue wild) with (*Figure out if there is a constant, will always be kept in first entry of tuple*)
            |Const _ -> addBaseValues (wild) (Const c)
            |Var v -> Add(Const c,wild)
            |_ -> raise InvalidInput)
        |(wild, Const c) -> (match (findBaseValue wild) with
            |Const _ -> addBaseValues (wild) (Const c)
            |Var v -> Add(Const c,wild)
            |_ -> raise InvalidInput)
        
        
        (*Composite types left*)
        
         |(a,b) -> match (findBaseValue a, findBaseValue b) with 
            |(Const _, Const _) -> addBaseValues a b (*Will take 2 expressions and do relevant add, adding only if there are 2 constants, else leaving the same*)
            (*Possibility that combineBaseValues doesn't maintain the structure*)
                |_ -> Add(a,b)
            
            
            (*match (findBaseValue a, findBaseValue b) with (*The value must be a const to add anything, else leave the same*)
            |(Const _, Const _) -> addBaseValue a *)

        
        
        (* |_ -> raise InputError *)   
        
        )
|Const c -> Const c
|Var v -> Var v

(* and convertAdd (e:expr) :expr= match e with *)


(* Test cases
let addOne = Add(Const 5, Var "x");;
let addTwo = Add(Var "a", Var "b");;
let addThree = Add(Const 5, Const 4);;
let addFour = Add(Var "c", Const 1);;
let addFive = Add(Var "y", Var "z");;

convertR (Add(Add(Add(Add(addOne,addTwo),addThree),addFour),addFive));;
Add (Add (Add (Add (Const 15, Var "c"), Var "x"), Add (Var "b", Var "a")),Add (Var "z", Var "y"))


convertR (Mul(Add(Mul(Const 5, Var "x"), Var "y"), Const 10));;
Add (Mul (Const 50, Var "x"), Mul (Var "y", Const 10))


let termOne = Mul(Const 20, Var "a");;
let termTwo = Mul(Var "b", Var "c");;

let seqOne=  Add(termOne,termTwo);;

let termThree = Mul(Const 2, Var "d");;
let termFour = Mul(Const 3, Const 5);;

let seqTwo = Add(termThree,termFour);;


convertR (Mul(Add(seqOne,seqTwo),Const 10));;
Add (Add (Mul (Var "a", Const 200), Mul (Var "b", Mul (Var "c", Const 10))), Add (Const 150, Mul (Var "d", Const 20)))

convertR (Mul(Mul(Var "x", Var "y"), Mul(Const 20, Var "x")));;
Mul (Var "x", Mul (Var "y", Mul (Var "x", Const 20)))

convertR (Mul(Mul(Var "x", Const 5), Mul(Const 20, Var "x")));;
Mul (Var "x", Mul (Var "x", Const 100))

reduce (Add (Const 0, Var "x"));;
Var "x"


reduce (Mul (Const 1, Var "y"));;
Var "y"

reduce (Mul (Const 1, (Add (Const 2, Const 4))));;
Const 6
*)



(*Problem 6*)
(*Make squareroot valid on unsafe input*)
let safesqrt x = if x < 0. then None else Some(sqrt(x));;
(* 
safesqrt (-49.);;
float option = None
safesqrt (49.);;
float option = Some 7. *)

(*Take a list and process it through an optional function, return all value holding elements*)
let process_all (lst: 'a list) (f: 'a -> 'b option) = List.map (fun x -> Option.get x)(List.filter (fun x -> if x = None then false else true) (List.map f lst));;

(* process_all [-1.0; 0.0; 4.0; 9.0; -16.0; 25.0] safesqrt;; 

float list = [0.; 2.; 3.; 5.]

*)