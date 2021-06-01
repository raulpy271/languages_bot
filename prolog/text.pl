
:- module(text, [text/2, text_languages_found/2]).

text_language(pt).

text(TextKey, Text) :-
    text_language(TextLanguage),
    insert_text(TextKey, TextLanguage, Text).

insert_text("saudation", pt, 
    "Ola, eu conheco diversas linguagens de programaçao. Posso te ajudar a escolher a mais adequada para voce.").

insert_text("area_interest", pt, "Qual area voce tem interesse?").

insert_text("paradigm", pt, "E qual paradigma de programaçao voce procurar?").

insert_text("type-system", pt, "Como eh o sistema de tipos mais adequada?").

insert_text("languages_found", pt, "As linguagens encontradas foram: ").

insert_text("choose_language", pt, "Qual delas voce quer saber mais? ").

insert_text("not_found", pt, "Nao foi encontrado linguagens com essas propriedades.").

insert_text("want_try_another", pt, "Nao se preocupe, posso te apresentar outra linguagem. Tem interesse?").

insert_text("bye", pt, "Ate logo!").

text_languages_found([], "").
text_languages_found(Languages, TextFormated) :-
    length(Languages, NumberOfLanguagesFound),
    NumberOfLanguagesFound > 0,
    convert_languages_to_string(Languages, LanguagesFormated),
    text("languages_found", LanguagesFoundText),
    text("choose_language", ChooseText),
    atom_concat(
        LanguagesFoundText, LanguagesFormated, LanguagesFoudFormated),
    atom_concat(LanguagesFoudFormated, ChooseText, TextFormated).

convert_languages_to_string([], "\n").
convert_languages_to_string(Languages, TextFormated) :-
    [Language | Rest ] = Languages,
    convert_languages_to_string(Rest, RestItens),
    language(Name, _, _, _, _, _, _) = Language,
    atom_concat("\n - ", Name, Item),
    atom_concat(Item, RestItens, TextFormated).

