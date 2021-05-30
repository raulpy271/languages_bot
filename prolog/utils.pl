
:- module(utils, [read_string/1, is_positive_answer/1]).

read_string(String) :-
  read(Atom),
  atom_string(Atom, String).

is_positive_answer(String) :-
    downcase_atom(String, DownCaseAtom),
    atom_string(DownCaseAtom, DownCaseString),
    member(DownCaseString, ["yeah", "yes", "sim"]).

