% insert(Num, List, NewList)
% Base Case
insert(Num, [], [Num]).

% If Num <= Head, add it at the first
insert(Num, [Head|Tail], [Num, Head|Tail]) :-
    Num =< Head.

% Else, add it to the end.
insert(Num, [Head|Tail], [Head|NewTail]) :-
    insert(Num, Tail, NewTail).

% isort(List, NewList)
isort([], []).

isort([Head], [Head]).

% sort the tail then insert the head
isort([Head|Tail], NewList) :-
    isort(Tail, Tail_sorted),
    insert(Head, Tail_sorted, NewList).

% split(BigList, List1, List2)
split([], [], []).

split([H], [H], []).

split([H1, H2|Tail], [H1|NewTail1], [H2|NewTail2]):-
    split(Tail, NewTail1, NewTail2).

% merge(Sort1, Sort2, Sort)
merge([], [], []).

merge(Head, [], Head).

merge([], Head, Head).

merge([Head1|Tail1], [Head2|Tail2], [Head1|NewTail]):-
    Head1 < Head2,
    merge(Tail1, [Head2|Tail2], NewTail).

merge([Head1|Tail1], [Head2|Tail2], [Head2|NewTail]):-
    Head1 >= Head2,
    merge([Head1|Tail1], Tail2, NewTail).

% mergesort(List, NewList)
% can use split/3 and merge/3
mergesort([], []).

mergesort([Head], [Head]).

mergesort(List, NewList):-
    split(List, Half1, Half2),
    mergesort(Half1, NList1),
    mergesort(Half2, NList2),
    merge(NList1, NList2, NewList).