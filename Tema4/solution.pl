

zebra_owner(Owner) :-
	houses(Hs),
	member(h(Owner,zebra,_,_,_), Hs).

water_drinker(Drinker) :-
	houses(Hs),
	member(h(Drinker,_,_,water,_), Hs).
	
next_to_spanish(N) :-
    houses(Hs),
    (adjacent(h(N, _, _, _, _), h(spanish, _, _, _, _), Hs);
    adjacent(h(spanish, _, _, _, _), h(N, _, _, _, _), Hs)).


houses(Hs) :-
	length(Hs, 5),                                            %  1
	member(h(english,_,_,_,red), Hs),                         %  2
	member(h(spanish,dog,_,_,_), Hs),                         %  3
	member(h(_,_,_,coffee,green), Hs),                        %  4
	member(h(ukrainian,_,_,tea,_), Hs),                       %  5
	adjacent(h(_,_,_,_,green), h(_,_,_,_,white), Hs),             %  6
	member(h(_,snails,old_gold,_,_), Hs),                       %  7
	member(h(_,_,kool,_,yellow), Hs),                         %  8
	Hs = [_,_,h(_,_,_,milk,_),_,_],                           %  9
	member(h(norwegian,_,_,_,_), Hs),                           % 10
	adjacent(h(_,fox,_,_,_), h(_,_,chesterfield,_,_), Hs),        % 11
	adjacent(h(_,_,kool,_,_), h(_,horse,_,_,_), Hs),              % 12
	member(h(_,_,lucky,juice,_), Hs),                         % 13
	member(h(japanese,_,parliament,_,_), Hs),                       % 14
	adjacent(h(norwegian,_,_,_,_), h(_,_,_,_,blue), Hs),          % 15
	member(h(norwegian,_,chesterfield,_,_), Hs),               % norwegian smokes chesterfield
	member(h(_,_,_,water,_), Hs),		% one of them drinks water
	member(h(_,zebra,_,_,_), Hs).		% one of them owns a zebra

adjacent(A, B, Ls) :- append(_, [A,B|_], Ls).
adjacent(A, B, Ls) :- append(_, [B,A|_], Ls).

