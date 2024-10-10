%river crossing
other_bank(e,w).
other_bank(w,e).

move([X,X,G,C], wolf,[Y,Y,G,C]):-other_bank(X,Y).
move([X,W,X,C], goat,[Y,W,Y,C]):-other_bank(X,Y).
move([X,W,G,X], cabbage,[Y,W,G,Y]):-other_bank(X,Y).
move([X,W,G,C], farmer,[Y,W,G,C]):-other_bank(X,Y).

safety_ck(X,X,_).
safety_ck(X,_,X).

safe_status([M, W, G, C]):-
    safety_ck(M,G,W),
    safety_ck(M,G,C).

solution([e,e,e,e],[]).
solution(Config, [Move | OtherMoves] ):-
          move(Config, Move, NextConfig),
          safe_status(NextConfig),
          solution(NextConfig, OtherMoves).
