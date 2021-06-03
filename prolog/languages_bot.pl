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
    ask_user_interest(AreaOfInterest, Paradigm, TypeSystem),
    search_languages(AreaOfInterest, Paradigm, TypeSystem, LanguagesFound),
    (LanguagesFound \= []
        -> select_language_details(LanguagesFound)
        ; text("not_found", LanguagesNotFoundText),
          writeln(LanguagesNotFoundText),
          try_another_language
    ).

ask_user_interest(AreaOfInterest, Paradigm, TypeSystem) :-
    text("area_interest", AreaOfInterestText),
    text("type-system", TypeSystemText),
    text("paradigm", ParadigmText),
    writeln(AreaOfInterestText),
    read(AreaOfInterest),
    writeln(TypeSystemText),
    read(TypeSystem),
    writeln(ParadigmText),
    read(Paradigm).

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


