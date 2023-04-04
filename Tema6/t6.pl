% predicat pentru a calcula inaltimea unui nod
height(nil, 0).
height(tree(_, L, R), H) :-
    height(L, HL),
    height(R, HR),
    H is max(HL, HR) + 1.

% predicat pentru a verifica daca un arbore binar este echilibrat
balanced(nil).
balanced(tree(_, L, R)) :-
    height(L, HL),
    height(R, HR),
    abs(HL - HR) =< 1,
    balanced(L),
    balanced(R).

% predicat pentru a cauta o valoare intr-un arbore binar echilibrat si a afisa drumul de la radacina
% predicat pentru a cauta o valoare intr-un arbore binar echilibrat si a afisa drumul de la radacina
search_balanced(nil, _, _) :-
    false.
search_balanced(Tree, X, Path) :-
    balanced(Tree),
    search_balanced_aux(Tree, X, [X], Path).

search_balanced_aux(tree(X, _, _), X, Path, Path).
search_balanced_aux(tree(Y, L, _), X, AccPath, Path) :-
    X < Y,
    append(AccPath, [Y], NewPath),
    search_balanced_aux(L, X, NewPath, Path).
search_balanced_aux(tree(Y, _, R), X, AccPath, Path) :-
    X > Y,
    append(AccPath, [Y], NewPath),
    search_balanced_aux(R, X, NewPath, Path).
