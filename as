%4queeen
perm([X|Y], Z):- perm(Y,W), delete_member(X,Z,W).
perm([],[]).

delete_memebr(X, [X|R], R).
delete_member(X, [F|R], [F|S]):- delete_member(X,R,S).

solve(P):-
    perm([1,2,3,4,5,6,7,8], P),
    combine([1,2,3,4,5,6,7,8], P,S,D),
    all_diff(S),
    all_diff(D).

combine([X1|X], [Y1|Y], [S1|S], [D1|D]):-
    S1 is X1 + Y1,
    D1 is X1 - Y1,
    combine(X,Y,S,D),
combine([],[],[],[]).

all_diff([X|Y]):- \+member(X,Y), all_diff(Y).
%all_diff([X]).



%missanarie.....

% inital State: all are in left or right
initial_state(state(3,3,0,0, left)).
initial_state(state(0,0,3,3, right)).

%valid state -> check the is state valid or not
valid(state(ML,CL, MR,CR, _)) :-
    ML >=0, CL >=0, MR >=0, CR >=0,
    %for left side
    (ML = 0; ML >= CL),
    %for right side
    (MR = 0; MR >= CR).

% Move definition Left to Right : 5 movement
move(state(ML, CL, MR,CL, left), state(ML2, CL2, MR2, CL2, right)):-

    % Move 2 missionaries to right
    ML2 is ML - 2, MR2 is MR + 2, CL2 is CL, CR2 is CR,

    % Move 2 cannibal to right
    ML2 is ML, MR2 is MR, CL2 is CL -2, CR2 is CR + 2,

    % Move one canibale and missenary
    ML2 is ML - 1, MR2 is MR +1, CL2 is CL - 1, CR2 is CR + 1,

    % Move a missanary to right
    ML2 is ML - 1, MR2 is MR + 1, CL2 is CL, CR2 is  CR,

    % Move a cannible to right
    ML2 is ML, MR2 is MR, CL2 is CL -1, CR2 is CR +1.

% Move state Right to Left
move(state(ML, CL, MR, CR, right), state(ML2, CL2, MR2, CR2, left)):-

    % Move 2 missionary to Left
    MR2 is MR - 2, ML2 is ML -2, CR2 is CR, CL2 is CL,

    %Move 2 cannibles to left
    MR2 is MR, ML2 is ML, CR2 is CR -2, CL2 is CL +2,

    % Move 1 missionary and 1 cannible
    MR2 is MR -1, ML2 is ML +1, CR2 is CR - 1, CL2 is CL +1,

    % Move 1 missionary
    MR2 is MR - 1, ML2 is ML + 1, CR2 is CR, CL2 is CL,

    % MOve 1 cannibale
    MR2 is MR, ML2 is ML, CR2 is CR -1, CL2 is CL +1.


%state transistion check whter valid move or not
transition(State, NextState):-
    move(State, NextState),
    valid(NextState).

%slove the problem
solve :-
    initial_state(State),
    goal_state(G),
    path(State, G,[State], Path),
    print_path(Path).

% Path - finding
path(Goal, Goal, Path, Path).
path(State, Goal, Visited, Path):-
    transition(State, NextState),
    \+ member(NextState, Visited),
    path(NextState, Goal, [NextState| Visited], Path).

%Print the solution
print_path([]).
print_path([State|Rest]):-
    write(State),nl,
    print_path(Rest).

% to run
start:- solve.
