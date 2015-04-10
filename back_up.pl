%Group: Kepler ,~Truth Value Checker~....start with ?- start.

start:-write('\n                ~~~~~Welcome to Truth Value Checker~~~~~                  '),nl,
					check_all_possible_truth_values.

check_all_possible_truth_values :- write('\nChecking all truth values... \n'),print_all,nl,!.

%print_all
print_all :- write('method called').   

%find_variables
:- op(1000,xfy,'and').
:- op(1000,xfy,'or').
:- op(900,fy,'not').

find_variables(N,V,V) :- member(N,[0,1]),!.
find_variables(X,Vin,Vout) :- atom(X), 
                         (member(X,Vin) -> Vout = Vin ; Vout = [X|Vin]).
find_variables(X and Y,Vin,Vout) :- find_variables(X,Vin,Vtemp),
                               find_variables(Y,Vtemp,Vout).
find_variables(X or Y,Vin,Vout) :-  find_variables(X,Vin,Vtemp),
                               find_variables(Y,Vtemp,Vout).
find_variables(not X,Vin,Vout) :-   find_variables(X,Vin,Vout).							   
							   
%retrieve_initial_truth_values
initial_assign([],[]).
initial_assign([X|R],[0|S]) :- initial_assign(R,S).

%generate_truth_value_for_particular_values
successor(A,S) :- reverse(A,R) , next(R,N) , reverse(N,S).

next([0|R],[1|R]).
next([1|R],[0|S]) :- next(R,S).

truth_value(N,_,_,N) :- member(N,[0,1]).
truth_value(X,Vars,A,Val) :- atom(X) , lookup(X,Vars,A,Val).
truth_value(X and Y,Vars,A,Val) :- truth_value(X,Vars,A,VX) , truth_value(Y,Vars,A,VY),
																											boole_and(VX,VY,Val).
truth_value(X or Y,Vars,A,Val) :-  truth_value(X,Vars,A,VX) , truth_value(Y,Vars,A,VY),
																											boole_or(VX,VY,Val).
truth_value(not X,Vars,A,Val) :-   truth_value(X,Vars,A,VX) , boole_not(VX,Val).	

lookup(X,[X|_],[V|_],V).
lookup(X,[_|Vars],[_|A],V) :- lookup(X,Vars,A,V).
	
boole_and(0,0,0).
boole_and(0,1,0).
boole_and(1,0,0).
boole_and(1,1,1).
boole_or(0,0,0).
boole_or(0,1,1).
boole_or(1,0,1).
boole_or(1,1,1).
boole_not(0,1).
boole_not(1,0).					   

%check merge  