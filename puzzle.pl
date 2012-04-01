add(X, Y, Z) :- Z = X + Y.
mul(X, Y, Z) :- Z = X * Y.
glu(X, Y, Z) :- number_atom(X, Xa),
                number_atom(Y, Ya),
                atom_concat(Xa, Ya, XYa),
                number_atom(Z, XYa).

fold_opt(_, [A], [A]).
fold_opt(Op, [A|[B|C]], Result) :-
    call(Op, A, B, AB), fold_opt(Op, [AB|C], Result);
    fold_opt(Op, [B|C], R), Result = [A|R].

fold(_, [A], [A]).
fold(Op, [A|[B|C]], Result) :-
    call(Op, A, B, AB), fold(Op, [AB|C], Result).

puzzle(List0, Result, Num) :-
    fold_opt(glu, List0, List1),
    fold_opt(mul, List1, List2),
    fold(add, List2, Result),
    Num is Result.

puzzle9(Result, Num) :- puzzle([1,2,3,4,5,6,7,8,9], Result, Num).
