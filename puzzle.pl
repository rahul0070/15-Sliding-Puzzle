:- [puzzle_legal_moves].
:- [functions].
% 15 sliding problem

% Move function to assign valid moves
move(S1,S2) :-  left(S1,S2).
move(S1,S2) :-  up(S1,S2).
move(S1,S2) :-  right(S1,S2).
move(S1,S2) :-  down(S1,S2).


heuristic(Start, Goal, Result) :- calculate(Start, Goal, 0, 0, 0, Res), Result is Res.


calculate([], _, _, _, Res, Dis) :- Dis is Res.
calculate([M|N], Final, P1, P2, Res, Dis) :- indexOf(M, Final, P2, P2F), distance(P1, P2F, R), Res1 is Res + R,
										P11 is P1 + 1,
										calculate(N, Final, P11, 0, Res1, Dis).

% Uncomment the euclidean distance function to use it instead of manhattan.
distance(C1,C2,D):-
  coordinateX(C1,X1),
  coordinateY(C1,Y1),
  coordinateX(C2,X2),
  coordinateY(C2,Y2),
  %manhattan(X1,Y1,X2,Y2,D),
  euclidean(X1,Y1,X2,Y2,D).

coordinateX(P,X):- M is mod(P,4), M=0, X is 4,!.
coordinateX(P,X):- X is mod(P,4).

coordinateY(P,Y):- M is mod(P,4), M=0, Y is P/4,!.
coordinateY(P,Y):- Y is truncate(P/4+1).


% Cost of switching two tiles is 1. 
cost(_, _, C) :-
    C is 1.


% Function for calculatting Manhattan & Euclidean distance given the coordinates.
manhattan(R1, C1, R2, C2, Result) :- R is (R1 - R2),
                C is (C1 - C2),
                abs2(C, CF),
                abs2(R, RF),
                Result is (CF + RF).

euclidean(R1, C1, R2, C2, Result) :- cal(R1, R2, A), cal(C1, C2, B), Res is A + B, Result is sqrt(Res).

