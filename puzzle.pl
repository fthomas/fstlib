add(X, Y, Z) :- Z is X + Y.
mul(X, Y, Z) :- Z is X * Y.
glu(X, Y, Z) :-
    number_atom(X, Xatom),
    number_atom(Y, Yatom),
    atom_concat(Xatom, Yatom, XYatom),
    number_atom(Z, XYatom).

op(add).
op(mul).
op(glu).

puzzle(Result, [O1, O2, O3, O4, O5, O6, O7, O8, O9]) :-
    op(O1), op(O2), op(O3), op(O4), op(O5), op(O6), op(O7), op(O8),
    call(O1,  1, 2, R1),
    call(O2, R1, 3, R2),
    call(O3, R2, 4, R3),
    call(O4, R3, 5, R4),
    call(O5, R4, 6, R5),
    call(O6, R5, 7, R6),
    call(O7, R6, 8, R7),
    call(O8, R7, 9, Result).
