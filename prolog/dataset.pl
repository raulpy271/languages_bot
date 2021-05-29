
:- module(dataset, [get_languages/1]).

:- use_module(library(csv)).

get_languages(Languages) :- 
    CSVFile = "dataset/all_languages.tsv",
    csv_read_file(CSVFile, LanguagesWithCol, [functor(language), arity(7)]),
    [ _ | Languages ] = LanguagesWithCol.

