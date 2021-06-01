#!/usr/bin/env swipl

:- use_module(dataset).
:- use_module(text).
:- use_module(utils).
:- use_module(search).

:- initialization(main, main).

main(_) :-
    text("saudation", Saudation),
    writeln(""),
    writeln(Saudation),
    conversation.

conversation :-
    Paradigm = '',
    TypeSystem = '',
    text("area_interest", AreaOfInterestText),
    writeln(AreaOfInterestText),
    read(AreaOfInterest),
    search_languages(AreaOfInterest, Paradigm, TypeSystem, LanguagesFound),
    text_languages_found(LanguagesFound, LanguagesFoundText),
    (LanguagesFoundText \= ""
        -> writeln(LanguagesFoundText)
        ; not_found_conversation
    ).

not_found_conversation :-
    text("not_found", LanguagesNotFoundText),
    writeln(LanguagesNotFoundText),
    text("want_try_another", WantTryAnotherText),
    writeln(WantTryAnotherText),
    read(WantTryAnotherAnswer),
    (is_positive_answer(WantTryAnotherAnswer)
        -> conversation
        ; text("bye", ByeText),
          writeln(ByeText)
    ).


