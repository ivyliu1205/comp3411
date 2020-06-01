% Yiting Liu - z5211008
% Assignment 1 - Prolog and Search

% Q1.1: sumsq_even(Numbers, Sum)
% Sum the squares of only the even numbers in a list of integers

% base case: [] -> 0
sumsq_even([], 0).

% else if H is odd
sumsq_even([H|T], Sum) :-
    H mod 2 =:= 1,
    sumsq_even(T, Sum).

% else if H is even
sumsq_even([H|T], Sum) :-
    H mod 2 =:= 0,
    sumsq_even(T, NewSum),
    Sum is NewSum + H * H.

% Q1.2: log_table(NumberList,ResultList)
% binds ResultList to the list of pairs consisting of a number and its log, for each number in NumberList.

% base case: [] -> []
log_table([], []).

% else
log_table([H|T], [[H, LogNumber]| NewT]) :-
    log_table(T, NewT),
    LogNumber is log(H).

% Q1.3: paruns(List,RunList)
% converts a list of numbers into the corresponding list of parity runs

% Main operation. Dividing a list into Even list and Odd list, and combine them. Then back again.
paruns([], []).
paruns(List, [Even, Odd|Tail]) :-
    paruns_help_even(List, Even, Rest),
    paruns_help_odd(Rest, Odd, NewRest),
    paruns(NewRest, Tail).

paruns_help_even([], [], []).
% If the first element is even, check next element.
paruns_help_even([H|T], [H|MoreEle], Rest) :-
    H mod 2 =:= 0,
    paruns_help_even(T, MoreEle, Rest).
% If the first element is odd.
paruns_help_even([H|T], [], [H|T]) :-
    H mod 2 =:= 1.

paruns_help_odd([], [], []).
% If the head is odd, check next element.
paruns_help_odd([H|T], [H|MoreEle], Rest) :-
    H mod 2 =:= 1,
    paruns_help_odd(T, MoreEle, Rest).
% If the head is even.
paruns_help_odd([H|T], [], [H|T]) :-
    H mod 2 =:= 0.

% Q1.4: eval(Expr, Val)
% evaluate expressions

% if A is a number
eval(A, V) :-
    number(A),
    V = A.

% add(A, B) = A + B
eval(add(A, B), V) :-
    eval(A, V1),
    eval(B, V2),
    V is V1 + V2.

% sub(A, B) = A - B
eval(sub(A, B), V) :-
    eval(A, V1),
    eval(B, V2),
    V is V1 - V2.

% mul(A, B) = A * B
eval(mul(A, B), V) :-
    eval(A, V1),
    eval(B, V2),
    V is V1 * V2.

% div(A, B) = A / B
eval(div(A, B), V) :-
    eval(A, V1),
    eval(B, V2),
    V is V1 / V2.
