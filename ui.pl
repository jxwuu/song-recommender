% module for all the user interface

% -----USER INTERFACE-----
% UI main page, user can select either natural language ui or general ui
mainUI :-
	write("__        __   _\n"),
	write("\\ \\      / /__| | ___ ___  _ __ ___   ___\n"),
    write(" \\ \\ /\\ / / _ \\ |/ __/ _ \\| '_ ` _ \\ / _ \\\n"),
    write("  \\ V  V /  __/ | (_| (_) | | | | | |  __/\n"),
    write("   \\_/\\_/ \\___|_|\\___\\___/|_| |_| |_|\\___|\n"),
	write("Welcome to our application -> Song Recommender\n"),
	write("Please select the UI -> General User Interface (g), Natural Language User Interface(n)"),
	readln(Input),
	( isNumber(Input) ->
	writeln("Sorry! I only accept words\n")
;	not(isNaturalOrSimple(Input)) ->
	writeln("Sorry! That is not a valid option\n") 
;	simpleOrNatural(Input)
).

% User can select the features in simple UI
simpleUI :-
	%write("Welcome to our application -> Song Recommender\n"),
	write("Please select the category for the tag -> TopTrack (track), TopArtist (artist), TopAlbums (album)"),
	readln(Input),
	(isNumber(Input) ->
	writeln("Sorry! I only accept words\n")
;   not(isTrackOrArtistOrAlbum(Input)) ->
	writeln("Sorry! That is not a valid option\n") 
;	trackOrArtistOrAlbum(Input)
).

% ui that handle toptrack
topTrackUI :-
	write("\n-------------------------------------------\n"),
	write("-----------------Top Track-----------------\n\n"),
	write("Please also select a \"tag\" for genre/artist/year, and I'll return the top 5 songs of that category!\n"),
    write('Please enter \"genre\", \"artist\", or \"year\": '), flush_output(current_output),
    readln(Input),
	( isNumber(Input) ->
	writeln("Sorry! I only accept words\n")
;	not(isGenreOrArtist(Input)) ->
	writeln("Sorry! That is not a valid option\n") 
;	genreOrArtistTrack(Input)
).

%ui that handle topartist
topArtistUI :-
	write("\n-------------------------------------------\n"),
	write("-----------------Top Artist----------------\n\n"),
	write("Please also select a \"tag\" for genre/artist/year, and I'll return the top 5 songs of that category!\n"),
    write('Please enter \"genre\" or \"year\": '), flush_output(current_output),
    readln(Input),
	( isNumber(Input) ->
	writeln("Sorry! I only accept words\n")
;	not(isGenreOrArtist(Input)) ->
	writeln("Sorry! That is not a valid option\n") 
;	genreOrArtistArtist(Input)
).

% ui that handle topalbum
topAlbumsUI :- 
	write("\n-------------------------------------------\n"),
	write("-----------------Top Albums----------------\n\n"),
    write("Please also select a \"tag\" for genre/artist/year, and I'll return the top 5 songs of that category!\n"),
    write('Please enter \"genre\", \"artist\", or \"year\": '), flush_output(current_output),
    readln(Input),
	( isNumber(Input) ->
	writeln("Sorry! I only accept words\n")
;	not(isGenreOrArtist(Input)) ->
	writeln("Sorry! That is not a valid option\n") 
;	genreOrArtistAlbums(Input)
).


% natural Language interface
naturalUI :-
	%write("Welcome to our application -> Song Recommender\n"),
	write("Please enter your question! We will analyze your question and return the top 5 songs\n"),
	readln(Input),
	parseInput(Input, []).
% "I like Justin Bieber"
% "Show me the top album of 2020"
% "I really like Justin Bieber"
% "What is the top song of 2021"
% "What is the top song of 2020"
% "What is the top album of 2020"
% "What is the top album of Justin Bieber"
% "Top album of Justin Bieber"
% "Who is the top artist of 2020"
% "I like pop music"
% "I love pop music"
% "top song"
% "Justin Bieber"
% "pop music"
% "rock music"
% "Top album of pop music"