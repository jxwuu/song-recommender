:- module(naturalLag, [parseInput/2]). 

% module that handle natural language 

% some of the natural language functions are from the lecture, but I did lots of modification to fit our project
% A noun phrase is a determiner followed by adjectives followed
% by a noun followed by an optional modifying phrase:
noun_phrase(L0,L3) :-
    det(L0,L1),
    adjectives(L1,L2),
    noun(L2,L3).

% parse the input
parseInput(['Is' | L0],L1) :-
    noun_phrase(L0,L1).
parseInput(['What',is | L0],L1) :-
    noun_phrase(L0,L1).
parseInput(['What' | L0],L1) :-
    noun_phrase(L0,L1).
parseInput(['I', like | L0],L1) :-
    noun_phrase(L0,L1).
parseInput(['I', love | L0],L1) :-
    noun_phrase(L0,L1).
parseInput(['I', really, like | L0],L1) :-
    noun_phrase(L0,L1).
parseInput(['I', really, love | L0],L1) :-
    noun_phrase(L0,L1).
parseInput(['Who', is | L0],L1) :-
    noun_phrase(L0,L1).
parseInput(['Which', is | L0],L1) :-
    noun_phrase(L0,L1).
parseInput(['Which'| L0],L1) :-
    noun_phrase(L0,L1).
parseInput(['Show', me| L0],L1) :-
    noun_phrase(L0,L1).
parseInput(L0,L1) :-
    noun_phrase(L0,L1).

% Handle the determiners 
det([the | L],L).
det([a | L],L).
det(L,L).

% handle adjective
adjectives(L0,L2) :-
    adj(L0,L1),
    adjectives(L1,L2).
adjectives(L,L).

% DICTIONARY of adj
adj([top, song, of | L],[]) :- feature(L, track).
adj([top, song, in | L],[]) :- feature(L, track).
adj([top, album, of | L],[]) :- feature(L, album).
adj([top, album, in | L],[]) :- feature(L, album).
adj([top, artist, of | L],[]) :- feature(L, artist).
adj([top, artist, in | L],[]) :- feature(L, artist).
adj([top| L],L).
adj(['Top', song, of | L],[]) :- feature(L, track).
adj(['Top', song, in | L],[]) :- feature(L, track).
adj(['Top', album, of | L],[]) :- feature(L, album).
adj(['Top', album, in | L],[]) :- feature(L, album).
adj(['Top', artist, of | L],[]) :- feature(L, artist).
adj(['Top', artist, in | L],[]) :- feature(L, artist).
adj(['Top'| L],L).

noun(song,[]):- feature(topsong).
noun(songs,[]):- feature(topsong).
noun(album,[]):- feature(topalbum).
noun(albums,[]):- feature(topalbum).
noun(artist,[]):- feature(topartist).
noun(artists,[]):- feature(topartist).
noun([X | L],[]) :- append([X],L, Y), feature(Y, general).
%noun([X | L],L) :- feature(X).
noun([],[]).

% list of feature
% default is to search the tag in TopTrack 
feature(X, general) :- atomics_to_string(X, "+", InputStr), call_api_single_track(InputStr).
feature(X, track) :- atomics_to_string(X, "+", InputStr), call_api_single_track(InputStr).
feature(X, album) :- atomics_to_string(X, "+", InputStr), call_api_single_album(InputStr).
feature(X, artist) :- atomics_to_string(X, "+", InputStr), call_api_single_artist(InputStr).
% default tag is "pop"
% for top song or album
feature(topsong) :- call_api_single_track("pop").
feature(topalbum) :- call_api_single_album("pop").
feature(topartist) :- call_api_single_album("pop").