:- use_module(library(http/http_open)).
:- use_module(library(http/json)).


% Instruction
% type mainUI. to start the program
% cite: https://www.binarytides.com/linux-fun-commands/ for funny terminal output
% -----CONSTANTS-----

root_url("http://ws.audioscrobbler.com/2.0").
api_key("5dd0808d6f467e08e647a024417e7318").
api_method_toptrack("tag.gettoptracks").
api_method_topartists("tag.gettopartists").
api_method_albums("tag.gettopalbums").
possible_tagArray([genre, artist, year]).
possible_genreArray([rock,hip,hop,jazz, pop, heavy, metal, country, folk,blues, classical, rhythm, blues, electronic,
					dance, punk, soul, reggae, house, alternative, alt, funk, techno, disco, ambient, lofi, instrumental, gospel,
					singing, trance, grunge, swing, orchestra, world, dubstep, industrial, ska, soundtrack, hardcore, korean, chinese,
					death, progressive, drum, opera, emo, experimental, bluegrass, vocal]).
ui_tag([g,n]).
tag_option([track,artist,album]).

% -----URL BUILDING FUNCTIONS-----

% converts a Tag atom into the string "tag=<Tag>", for the "tag" URL parameter
param_tag(Tag, TagParam) :-
	string_concat("tag=", Tag, TagParam).

% converts a Method atom into the string "method=<Method>", for the "method" URL parameter
param_method(Method, MethodParam) :-
	string_concat("method=", Method, MethodParam).

% converts a Limit atom into the string "limit=<Limit>", for the "limit" URL parameter
param_limit(Limit, LimitParam) :-
	string_concat("limit=", Limit, LimitParam).

% converts a Key atom into the string "api_key=<Key>", for the "api_key" URL parameter
param_key(Key, KeyParam) :-
	string_concat("api_key=", Key, KeyParam).

% constructs the URL to make the API call with; example URL:
% http://ws.audioscrobbler.com/2.0/?method=tag.gettoptracks&tag=rock&limit=5&api_key=5dd0808d6f467e08e647a024417e7318&format=json
build_url_toptracks(Tag, URL) :-
	root_url(Root),
	api_key(Key),
	api_method_toptrack(Method),
	param_tag(Tag, TagParam),
	param_method(Method, MethodParam),
	param_limit(5, LimitParam),
	param_key(Key, KeyParam),
	string_concat(Root, "?", R1),
	string_concat(R1, MethodParam, R2),
	string_concat(R2, "&", R3),
	string_concat(R3, TagParam, R4),
	string_concat(R4, "&", R5),
	string_concat(R5, LimitParam, R6),
	string_concat(R6, "&", R7),
	string_concat(R7, KeyParam, R8),
	string_concat(R8, "&", R9),
	string_concat(R9, "format=json", URL).
	%% write(URL).

% constructs the URL to make the API call with; example URL:
% http://ws.audioscrobbler.com/2.0/?method=tag.gettopartists&tag=rock&limit=5&api_key=5dd0808d6f467e08e647a024417e7318&format=json
build_url_topartists(Tag, URL) :-
	root_url(Root),
	api_key(Key),
	api_method_topartists(Method),
	param_tag(Tag, TagParam),
	param_method(Method, MethodParam),
	param_limit(5, LimitParam),
	param_key(Key, KeyParam),
	string_concat(Root, "?", R1),
	string_concat(R1, MethodParam, R2),
	string_concat(R2, "&", R3),
	string_concat(R3, TagParam, R4),
	string_concat(R4, "&", R5),
	string_concat(R5, LimitParam, R6),
	string_concat(R6, "&", R7),
	string_concat(R7, KeyParam, R8),
	string_concat(R8, "&", R9),
	string_concat(R9, "format=json", URL).
	%% write(URL).

	% constructs the URL to make the API call with; example URL:
% http://ws.audioscrobbler.com/2.0/?method=tag.gettopalbums&tag=rock&limit=5&api_key=5dd0808d6f467e08e647a024417e7318&format=json
build_url_topalbums(Tag, URL) :-
	root_url(Root),
	api_key(Key),
	api_method_albums(Method),
	param_tag(Tag, TagParam),
	param_method(Method, MethodParam),
	param_limit(5, LimitParam),
	param_key(Key, KeyParam),
	string_concat(Root, "?", R1),
	string_concat(R1, MethodParam, R2),
	string_concat(R2, "&", R3),
	string_concat(R3, TagParam, R4),
	string_concat(R4, "&", R5),
	string_concat(R5, LimitParam, R6),
	string_concat(R6, "&", R7),
	string_concat(R7, KeyParam, R8),
	string_concat(R8, "&", R9),
	string_concat(R9, "format=json", URL).
	%% write(URL).

% -----API CALLER AND JSON HANDLERS-----

% converts dictionary Dict that json_read_dict() (in make_api_call()) returns
% into the list of songs the JSON contains
json_to_songs_track(Dict, Dict.tracks.track).
json_to_songs_artist(Dict, Dict.topartists.artist).
json_to_songs_alblum(Dict, Dict.albums.album).

% writes the "name" field of each Track to the console
% Handle Top track and top album
write_songnames_track([]).
write_songnames_track([Track|T]) :-
	Song_name = Track.name,
 	Song_artist = Track.artist.name,
	Song_url = Track.url,
	string_concat("Artist", ": ", Artist),
	string_concat(Artist, Song_artist, Artist_name),
	string_concat(Artist_name, "\nSong: ", Song_artistD1), 
 	string_concat(Song_artistD1, Song_name, Song_artist_name),
	string_concat(Song_artist_name, "\nLink: ", Song_artist_name2),
	string_concat(Song_artist_name2, Song_url, Song_artist_name3),  
 	string_concat(Song_artist_name3, "\n\n", Song_final),
 	write(Song_final),
  	write_songnames_track(T).

% Handle Top artist
write_songnames_artist([]).
write_songnames_artist([Track|T]) :-
	Song_name = Track.name,
 	%Song_artist = Track.artist.name,
	Song_url = Track.url,
	string_concat("Top Artist", ": ", Artist),
	string_concat(Artist, Song_name, Artist_name),
	string_concat(Artist_name, "\nLink: ", Song_artist_name2),
	string_concat(Song_artist_name2, Song_url, Song_artist_name3),  
 	string_concat(Song_artist_name3, "\n\n", Song_final),
 	write(Song_final),
  	write_songnames_artist(T).

% makes the HTTP get request to lastFMs API
% Songs is a list of Song atoms (Song is an atom representing a song name)
% CITATION: adapted from https://github.com/thibaultdewit/Interactive-Tour-Guide
make_api_call_track(URL, Songs) :-
	write("Connecting to LastFM Server......\n"),
	write(".................................\n\n"),
 	http_open(URL, In_stream, []),
 	json_read_dict(In_stream, Dict),
 	close(In_stream),
 	json_to_songs_track(Dict, Songs),
	(ifEmpty(Songs) ->
	write("Sorry! There were no songs found!")
;	write_songnames_track(Songs),
 	write("\n")).

make_api_call_artist(URL, Songs) :-
	write("Connecting to LastFM Server......\n"),
	write(".................................\n\n"),
 	http_open(URL, In_stream, []),
 	json_read_dict(In_stream, Dict),
 	close(In_stream),
 	json_to_songs_artist(Dict, Songs),
	(ifEmpty(Songs) ->
	write("Sorry! There were no songs found!")
;	write_songnames_artist(Songs),
 	write("\n")).

make_api_call_alblum(URL, Songs) :-
	write("Connecting to LastFM Server......\n"),
	write(".................................\n\n"),
 	http_open(URL, In_stream, []),
 	json_read_dict(In_stream, Dict),
 	close(In_stream),
 	json_to_songs_alblum(Dict, Songs),
	(ifEmpty(Songs) ->
	write("Sorry! There were no songs found!")
;	write_songnames_track(Songs),
 	write("\n")).

% builds the URL and makes the API call for this particular Item
% For top track
call_api_single_track(Item) :-
	write("(@@) (  ) (@)  ( )  @@    ()    @     O     @\n"),
	write("                     (   )                   \n"),
	write("                 (@@@@)                      \n"),
	write("              (    )                         \n"),
	write("            (@@@)							   \n"),
	write("         ====        ________                ___________\n"),
	write("     _D _|  |_______/        \\__I_I_____===__|_________|\n"),
	write("      |(_)---  |   H\\________/ |   |        =|___ ___|      ________________\n"),
	write("      /     |  |   H  |  |     |   |         ||_| |_||     _|\n"),
	write("     |      |  |   H  |__--------------------| [___] |   =|\n"),
	write("     | ________|___H__/__|_____/[][]~\\_______|       |   -|\n"),
	write("     |/ |   |-----------I_____I [][] []  D   |=======|____|_________________\n"),
	write("   __/ =| o |=-O=====O=====O=====O \\ ____Y___________|__|___________________\n"),
	write("    |/-=|___|=    ||    ||    ||    |_____/~\\___/          |_D__D__D_|  |_D_\n"),
	write("     \\_/      \\__/  \\__/  \\__/  \\__/      \\_/               \\_/   \\_/    \\_/\n"),
	write("Building Track URL............\n"),
	write("..............................\n\n"),
	%% atom_string(Item, ItemStr),
	build_url_toptracks(Item, URL),
	make_api_call_track(URL, _).

% For top artist
call_api_single_artist(Item) :-
write("(@@) (  ) (@)  ( )  @@    ()    @     O     @\n"),
	write("                     (   )                   \n"),
	write("                 (@@@@)                      \n"),
	write("              (    )                         \n"),
	write("            (@@@)							   \n"),
	write("         ====        ________                ___________\n"),
	write("     _D _|  |_______/        \\__I_I_____===__|_________|\n"),
	write("      |(_)---  |   H\\________/ |   |        =|___ ___|      ________________\n"),
	write("      /     |  |   H  |  |     |   |         ||_| |_||     _|\n"),
	write("     |      |  |   H  |__--------------------| [___] |   =|\n"),
	write("     | ________|___H__/__|_____/[][]~\\_______|       |   -|\n"),
	write("     |/ |   |-----------I_____I [][] []  D   |=======|____|_________________\n"),
	write("   __/ =| o |=-O=====O=====O=====O \\ ____Y___________|__|___________________\n"),
	write("    |/-=|___|=    ||    ||    ||    |_____/~\\___/          |_D__D__D_|  |_D_\n"),
	write("     \\_/      \\__/  \\__/  \\__/  \\__/      \\_/               \\_/   \\_/    \\_/\n"),
	write("Building Artist URL........\n"),
	write("..............................\n\n"),
	%% atom_string(Item, ItemStr),
	build_url_topartists(Item, URL),
	make_api_call_artist(URL, _).

% For top alblum
call_api_single_alblum(Item) :-
write("(@@) (  ) (@)  ( )  @@    ()    @     O     @\n"),
	write("                     (   )                   \n"),
	write("                 (@@@@)                      \n"),
	write("              (    )                         \n"),
	write("            (@@@)							   \n"),
	write("         ====        ________                ___________\n"),
	write("     _D _|  |_______/        \\__I_I_____===__|_________|\n"),
	write("      |(_)---  |   H\\________/ |   |        =|___ ___|      ________________\n"),
	write("      /     |  |   H  |  |     |   |         ||_| |_||     _|\n"),
	write("     |      |  |   H  |__--------------------| [___] |   =|\n"),
	write("     | ________|___H__/__|_____/[][]~\\_______|       |   -|\n"),
	write("     |/ |   |-----------I_____I [][] []  D   |=======|____|_________________\n"),
	write("   __/ =| o |=-O=====O=====O=====O \\ ____Y___________|__|___________________\n"),
	write("    |/-=|___|=    ||    ||    ||    |_____/~\\___/          |_D__D__D_|  |_D_\n"),
	write("     \\_/      \\__/  \\__/  \\__/  \\__/      \\_/               \\_/   \\_/    \\_/\n"),
	write("Building Alblum URL........\n"),
	write("..............................\n\n"),
	%% atom_string(Item, ItemStr),
	build_url_topalbums(Item, URL),
	make_api_call_alblum(URL, _).

% calls the api via call_api_single() for each Item in a list of Items
call_api([]).
call_api([Item|T]) :-
	call_api_single(Item),
	call_api(T).

% verifies if X is a number
isNumber([X]) :-
	number(X).

% verfiies if input is genre or artist or year
isGenreOrArtist([In]) :-
	possible_tagArray(P),
	member(In,P).


% verfiies if input is g or n (check UI)
isNaturalOrSimple([In]) :-
	ui_tag(P),
	member(In,P).

% verfiies if input is 1 or 2 or 3
isTrackOrArtistOrAlbum([In]) :-
	tag_option(P),
	member(In,P).

%% % verifies if Input is the atom 'genre'
%% ifGenre(Input) :-
%% 	Input = 'genre'.

%% % verfies if input is year
%% ifYear(Input) :-
%% 	Input = 'year'.

%% % verfies if input is artist
%% ifArtist(Input) :-
%% 	Input = 'artist'.

% verifies if no songs are found 
 ifEmpty(Songs) :-
 	Songs = [].


% verifies possible year input
isPossibleYear([Input]) :-
	number(Input),
	Input < 2022,
	Input > 1800.

% verifies if possible genre 
isPossibleGenre([]).
isPossibleGenre([Genre1 | Genre2]) :-
	possible_genreArray(Ga),
	member(Genre1, Ga),
	isPossibleGenre(Genre2).

% if input is genre then computes genre playlist
genreOrArtistTrack([Input]) :-
	Input = 'genre' ->
	chooseGenreTrack
;	Input = 'artist' ->
	chooseArtistTrack
;	Input = 'year' ->
	chooseYearTrack
; 	write("The input is not a year/artist/genre!\n").

genreOrArtistArtist([Input]) :-
	Input = 'genre' ->
	chooseGenreArtist
;	Input = 'year' ->
	chooseYearArtist
; 	write("The input is not a year/artist/genre!\n").

genreOrArtistAlbums([Input]) :-
	Input = 'genre' ->
	chooseGenreAlbums
;	Input = 'artist' ->
	chooseArtistAlbums
;	Input = 'year' ->
	chooseYearAlbums
; 	write("The input is not a year/artist/genre!\n").

simpleOrNatural([Input]) :-
	Input = 'g' ->
	simpleUI
;	Input = 'n' ->
	naturalUI
; 	write("The input is not a year/artist/genre!\n").

trackOrArtistOrAlbum([Input]) :-
	Input = 'track' ->
	topTrackUI
;	Input = 'artist' ->
	topArtistUI
;	Input = 'album' ->
	topAlbumsUI
; 	write("The input is not a track/artist/album!\n").

% given input of genre calls api and computes genre playlist
% For top track
chooseGenreTrack :-
	write("Enter a genre(s) (space-separated list):\n"), flush_output(current_output),
	readln(Input),
	(not(isNumber(Input)), isPossibleGenre(Input)) ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single_track(InputStr)
;	write("Sorry! That was not a valid genre\n").

% given input of artist calls api and computes artist playlist
chooseArtistTrack :-
	write("Enter an artist :\n"), flush_output(current_output),
	readln(Input),
	(not(isNumber(Input)), not(isPossibleGenre(Input)))  ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single_track(InputStr)
;	write("Sorry! That was not a valid input\n").

% given input of year calls api and computes year playlist
chooseYearTrack :-
	write("Enter a year:\n"), flush_output(current_output),
	readln(Input),
	(isPossibleYear(Input)) ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single_track(InputStr)
;	write("Sorry! Invalid year\n").

% For top artist
chooseGenreArtist :-
	write("Enter a genre(s) (space-separated list):\n"), flush_output(current_output),
	readln(Input),
	(not(isNumber(Input)), isPossibleGenre(Input))  ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single_artist(InputStr)
;	write("Sorry! That was not a valid genre\n").

% given input of artist calls api and computes artist playlist
chooseArtistArtist :-
	write("Enter an artist :\n"), flush_output(current_output),
	readln(Input),
	(not(isNumber(Input)), not(isPossibleGenre(Input))) ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single_artist(InputStr)
;	write("Sorry! That was not a valid input\n").

% given input of year calls api and computes year playlist
chooseYearArtist :-
	write("Enter a year :\n"), flush_output(current_output),
	readln(Input),
	(isPossibleYear(Input)) ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single_artist(InputStr)
;	write("Sorry! Invalid year\n").

% For top Albums
chooseGenreAlbums :-
	write("Enter a genre(s) (space-separated list):\n"), flush_output(current_output),
	readln(Input),
	(not(isNumber(Input)), isPossibleGenre(Input))  ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single_alblum(InputStr)
;	write("Sorry! That was not a valid genre\n").

% given input of artist calls api and computes artist playlist
chooseArtistAlbums :-
	write("Enter an artist :\n"), flush_output(current_output),
	readln(Input),
	(not(isNumber(Input)), not(isPossibleGenre(Input)))  ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single_alblum(InputStr)
;	write("Sorry! I only accept words\n").

% given input of year calls api and computes year playlist
chooseYearAlbums :-
	write("Enter a year :\n"), flush_output(current_output),
	readln(Input),
	(isPossibleYear(Input)) ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single_alblum(InputStr)
;	write("Sorry! Invalid year\n").

% -----USER INTERFACE-----
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
% working on it!
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
feature(X, album) :- atomics_to_string(X, "+", InputStr), call_api_single_alblum(InputStr).
feature(X, artist) :- atomics_to_string(X, "+", InputStr), call_api_single_artist(InputStr).
% default tag is "pop"
% for top song or album
feature(topsong) :- call_api_single_track("pop").
feature(topalbum) :- call_api_single_alblum("pop").
feature(topartist) :- call_api_single_alblum("pop").






