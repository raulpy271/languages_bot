#!/usr/bin/env swipl

:- use_module(dataset).
:- use_module(text).
:- use_module(utils).
:- use_module(search).

:- initialization(main, main).

main(_) :-
    text("saudation", Saudation),
    writeln(Saudation),
    conversation.

conversation :-
    Paradigm = '',
    TypeSystem = '',
    text("area_interest", AreaOfInterestText),
    writeln(AreaOfInterestText),
    read(AreaOfInterest),
    search_languages(AreaOfInterest, Paradigm, TypeSystem, LanguagesFound),
    (LanguagesFound \= []
        -> select_language_details(LanguagesFound)
        ; text("not_found", LanguagesNotFoundText),
          writeln(LanguagesNotFoundText),
          try_another_language
    ).

select_language_details(LanguagesFound) :-
    text_languages_found(LanguagesFound, LanguagesFoundText),
    writeln(LanguagesFoundText),
    read(LanguageSelectedName),
    (search_by_name(
            LanguageSelectedName, 
            LanguagesFound, 
            LanguageSelected)
        -> text_languages_details(LanguageSelected, TextFormated),
           writeln(TextFormated)
        ; text("not_found", LanguagesNotFoundText),
          writeln(LanguagesNotFoundText)
    ),
    try_another_language.

try_another_language :-
    text("want_try_another", WantTryAnotherText),
    writeln(WantTryAnotherText),
    read(WantTryAnotherAnswer),
    (is_positive_answer(WantTryAnotherAnswer)
        -> conversation
        ;  text("bye", ByeText),
           writeln(ByeText)
    ).


