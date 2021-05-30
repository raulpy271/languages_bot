
:- module(search, [match_language/4, search_languages/4]).

:- use_module(dataset).

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
  
search_languages(AreaOfInterest, Paradigm, TypeSystem, LanguagesFound) :-
    get_languages(Languages),
    filter_languages(
        Languages, 
        AreaOfInterest, 
        Paradigm, 
        TypeSystem, 
        LanguagesFound).

filter_languages([], _, _, _, []).
filter_languages(
        [Language | RestLanguages], 
        AreaOfInterest, 
        Paradigm, 
        TypeSystem, 
        LanguagesFound) :-
    match_language(Language, AreaOfInterest, Paradigm, TypeSystem),
    filter_languages(
        RestLanguages, 
        AreaOfInterest, 
        Paradigm, 
        TypeSystem,
        RestLanguagesFound),
    LanguagesFound = [Language | RestLanguagesFound].
filter_languages(
        [Language | RestLanguages], 
        AreaOfInterest, 
        Paradigm, 
        TypeSystem, 
        LanguagesFound) :-
    not(match_language(Language, AreaOfInterest, Paradigm, TypeSystem)),
    filter_languages(
        RestLanguages, 
        AreaOfInterest, 
        Paradigm, 
        TypeSystem,
        RestLanguagesFound),
    LanguagesFound = RestLanguagesFound.

