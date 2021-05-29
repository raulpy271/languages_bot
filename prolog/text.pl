
:- module(text, [text/3, text_languages_found/3]).

text("saudation", pt, 
    "Ola, eu conheco diversas linguagens de programaçao. Posso te ajudar a escolher a mais adequada para voce. Qual area voce tem interesse?").

text("paradigm", pt, "E qual paradigma de programaçao voce procurar?").

text("type-system", pt, "Como eh o sistema de tipos mais adequada?").

text("languages_found", pt, "As linguagens encontradas foram: ").

text("choose_language", pt, "Qual delas voce quer saber mais? ").

text("not_found", pt, "Nao foi encontrado linguagens com essas propriedades.").

text_languages_found(TextLanguage, Languages, TextFormated) :-
    length(Languages, NumberOfLanguagesFound),
    NumberOfLanguagesFound > 0,
    convert_languages_to_string(Languages, LanguagesFormated),
    text("languages_found", TextLanguage, LanguagesFoundText),
    text("choose_language", TextLanguage, ChooseText),
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

