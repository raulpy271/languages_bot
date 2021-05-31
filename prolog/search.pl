
:- module(search, [match_language/4, search_languages/4]).

:- use_module(dataset).

match_language(Language, AreaOfInterest, Paradigm, TypeSystem) :-
    language(_, _, About, _, LanguageTypes, LanguageParadigm, _) = Language,
    (
        (About \= '', AreaOfInterest \= ''
        -> downcase_atom(About, AboutLowered),
           downcase_atom(AreaOfInterest, AreaOfInterestLowered),
           sub_atom(AboutLowered, _, _, _, AreaOfInterestLowered)
        ;  false
        )
    ;
        (LanguageParadigm \= '', Paradigm \= ''
        -> downcase_atom(LanguageParadigm, LanguageParadigmLowered),
           downcase_atom(Paradigm, ParadigmLowered),
           sub_atom(LanguageParadigmLowered, _, _, _, ParadigmLowered)
        ;  false
        )
    ;
        (LanguageTypes \= '', TypeSystem \= ''
        -> downcase_atom(LanguageTypes, LanguageTypesLowered),
           downcase_atom(TypeSystem, TypeSystemLowered),
           sub_atom(LanguageTypesLowered, _, _, _, TypeSystemLowered)
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

