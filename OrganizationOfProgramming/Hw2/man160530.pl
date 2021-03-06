oddMultOf3(X) :-not(integer(X)) -> writeln("ERROR: The given parameter is not an integer."), fail ; not(0 is mod(X,2)), 0 is mod(X, 3).

list_prod([], 0).
list_prod([X], X).
list_prod([X|R], Product) :- list_prod(R, Y), Product is Y * X.

segregate([], [], []).
segregate([X|R], Even, Odd) :- 0 is mod(X, 2), segregate(R, E, O), append([X], E, Even), Odd = O.
segregate([X|R], Even, Odd) :- not(0 is mod(X, 2)), segregate(R, E, O), append([X], O, Odd), Even = E.

path(fresno,seattle).
path(fresno,boston).
path(fresno,albany).
path(seattle,omaha).
path(seattle,dallas).
path(omaha,albany).
path(omaha,atlanta).
path(albany,seattle).
path(albany,dallas).
path(atlanta,boston).
path(atlanta,dallas).
path(atlanta,albany).
path(dallas,albany).
path(dallas,seattle).

route(X, Y, Route) :- travel(X, Y, [X], R), reverse(R, Route).
travel(X, Y, V, [Y|V]) :- path(X, Y).
travel(X, Y, V, R) :- path(X, Z), not(Z == Y), not(member(Z, V)), travel(Z, Y, [Z|V], R).

male(adam).
male(bob).
male(brett).
male(charles).
male(chris).
male(clay).
female(ava).
female(barbara).
female(betty).
female(colette).
female(carrie).
parent(adam,bob).
parent(adam,barbara).
parent(ava,bob).
parent(ava,barbara).
parent(bob,clay).
parent(barbara,colette).

mother(X, Y) :- parent(X, Y), female(X).
father(X, Y) :- parent(X, Y), male(X).
child(X, Y) :- parent(Y, X).
sibling(X, Y) :- setof((X,Y), Z^(child(X, Z), child(Y, Z), \+X=Y), Sibs), member((X,Y), Sibs),\+ (Y@<X, member((Y,X), Sibs)).

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

grandmother(X, Y) :- parent(X, Z), parent(Z, Y), female(X).
grandfather(X, Y) :- parent(X, Z), parent(Z, Y), male(X).
grandchild(X, Y) :- parent(Z, X), parent(Y, Z).
grandson(X, Y) :- parent(Z, X), parent(Y, Z), male(X).
granddaughter(X, Y) :- parent(Z, X), parent(Y, Z), female(X).


