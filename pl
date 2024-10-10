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

%list
is_undergraduate('janak'):-
    student('Janaka',_,_).

register_student:-
    student(FirstName, LastName, IndexNo),
    format('~w ~w Index No: ~w ',[FirstName,LastName,IndexNo]),nl,fail.

index_silva:-
    student(_,'Silva',IndexNo),
    format('The index number of silva is ~w',[IndexNo]),nl,fail.

student_sat:-
    scores(IndexNo,_,_,_,_,_),
    student(FirstName,LastName,IndexNo),
    format('~w - ~w ~w sat exam.',[IndexNo,FirstName,LastName]),nl.

missed_exam:-
    student(FirstName,LastName,IndexNo),
    \+ scores(IndexNo,_,_,_,_,_),
    format('~w ~w missed the exam.',[FirstName, LastName]),nl,fail.

scored:-
    scores(_,UCT,SWT1, CIS, SWT2, NST),
    (   UCT =:= 100; SWT1=:=100; CIS=:=100; SWT2=:=100; NST=:=100),
    write('Yes, ~w scored 100'),nl.

who_scored:-
    scores(IndexNo,UCT,SWT1, CIS, SWT2, NST),
    student(FirstName,LastName,IndexNo),
    (   (UCT =:= 100,format('~w ~w scored 100 in UCT.',[FirstName,LastName]),nl);
    (SWT1 =:= 100, format('~w ~w scored 100 in SWT31012.', [FirstName, LastName]), nl);
     (CIS =:= 100, format('~w ~w scored 100 in CIS31012.', [FirstName, LastName]), nl);
     (SWT2 =:= 100, format('~w ~w scored 100 in SWT31022.', [FirstName, LastName]), nl);
     (NST =:= 100, format('~w ~w scored 100 in NST31022.', [FirstName, LastName]), nl)),fail.
