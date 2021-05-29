
:- module(search, [match_language/4]).

match_language(Language, AreaOfInterest, Paradigm, TypeSystem) :-
    language(_, _, About, _, LanguageTypes, LanguageParadigm, _) = Language,
    (
        (About \= '', AreaOfInterest \= ''
        -> sub_atom(About, _, _, _, AreaOfInterest)
        ;  false
        )
    ;
        (LanguageParadigm \= '', Paradigm \= ''
        -> sub_atom(LanguageParadigm, _, _, _, Paradigm)
        ;  false
        )
    ;
        (LanguageTypes \= '', TypeSystem \= ''
        -> sub_atom(LanguageTypes, _, _, _, TypeSystem)
        ;  false
        )
    ).
  
