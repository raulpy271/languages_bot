#!/usr/bin/env swipl

:- use_module(dataset).
:- use_module(text).
:- use_module(utils).
:- use_module(search).

:- initialization(main, main).

main(_) :-
    TextLanguage = pt,
    text("saudation", TextLanguage, Saudation),
    writeln(""),
    writeln(Saudation),
    conversation.

conversation :-
    Paradigm = '',
    TypeSystem = '',
    TextLanguage = pt,
    text("area_interest", TextLanguage, AreaOfInterestText),
    writeln(AreaOfInterestText),
    read(AreaOfInterest),
    search_languages(AreaOfInterest, Paradigm, TypeSystem, LanguagesFound),
    text_languages_found(TextLanguage, LanguagesFound, LanguagesFoundText),
    (LanguagesFoundText \= ""
        -> writeln(LanguagesFoundText)
        ; not_found_conversation
    ).

not_found_conversation :-
    text("not_found", TextLanguage, LanguagesNotFoundText),
    writeln(LanguagesNotFoundText),
    text("want_try_another", TextLanguage, WantTryAnotherText),
    writeln(WantTryAnotherText),
    read(WantTryAnotherAnswer),
    (is_positive_answer(WantTryAnotherAnswer)
        -> conversation
        ; text("bye", TextLanguage, ByeText),
          writeln(ByeText)
    ).


