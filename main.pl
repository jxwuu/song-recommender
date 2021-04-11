:- use_module(library(http/http_open)).
:- use_module(library(http/json)).



% -----CONSTANTS-----

root_url("http://ws.audioscrobbler.com/2.0").
api_key("5dd0808d6f467e08e647a024417e7318").
api_method("tag.gettoptracks").
api_artistMethod("artist.gettoptracks").
possible_tagArray([genre, artist, year]).



% -----URL BUILDING FUNCTIONS-----

% converts a Tag atom into the string "tag=<Tag>", for the "tag" URL parameter
param_tag(Tag, TagParam) :-
	string_concat("tag=", Tag, TagParam).

param_artist(Artist, ArtistParam) :-
	string_concat("artist=", Artist, ArtistParam).
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
build_url(Tag, URL) :-
	root_url(Root),
	api_key(Key),
	api_method(Method),
	param_tag(Tag, TagParam),
	param_method(Method, MethodParam),
	param_limit(10, LimitParam),
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
% http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=cher&limit=5&api_key=5dd0808d6f467e08e647a024417e7318&format=json
build_arturl(Artist, URL) :-
	root_url(Root),
	api_key(Key),
	api_method(Method),
	param_tag(Artist, ArtistParam),
	param_method(Method, MethodParam),
	param_limit(10, LimitParam),
	param_key(Key, KeyParam),
	string_concat(Root, "?", R1),
	string_concat(R1, MethodParam, R2),
	string_concat(R2, "&", R3),
	string_concat(R3, ArtistParam, R4),
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
json_to_songs(Dict, Dict.tracks.track).

% writes the "name" field of each Track to the console
write_songnames([]).
write_songnames([Track|T]) :-
	Song_name = Track.name,
 	Song_artist = Track.artist.name,
	Song_url = Track.url,
	string_concat("Artist", ": ", Artist),
	string_concat(Artist, Song_artist, Artist_name),
 	string_concat(Artist_name, " - ", Song_artistD),  
	string_concat(Song_artistD, " Song: ", Song_artistD1), 
 	string_concat(Song_artistD1, Song_name, Song_artist_name),
	string_concat(Song_artist_name, " - ", Song_artist_name1), 
	string_concat(Song_artist_name1, " Link: ", Song_artist_name2),
	string_concat(Song_artist_name2, Song_url, Song_artist_name3),  
 	string_concat(Song_artist_name3, "\n", Song_final),
 	write(Song_final),
  	write_songnames(T).

% makes the HTTP get request to lastFMs API
% Songs is a list of Song atoms (Song is an atom representing a song name)
% CITATION: adapted from https://github.com/thibaultdewit/Interactive-Tour-Guide
make_api_call(URL, Songs) :-
 	http_open(URL, In_stream, []),
 	json_read_dict(In_stream, Dict),
 	close(In_stream),
 	json_to_songs(Dict, Songs),
	%%ifempty(Songs) ->
	%%write("oh! we could not find any songs")
	write_songnames(Songs),
 	write("\n").

% builds the URL and makes the API call for this particular Genre
call_api_single(Genre) :-
	atom_string(Genre, GenreStr),
	build_url(GenreStr, URL),
	make_api_call(URL, _).
	%% write(Songs).

% builds the URL and makes the API call for this particular Genre
call_artapi_single(Artist) :-
	atom_string(Artist, ArtistStr),
	build_arturl(ArtistStr, URL),
	make_api_call(URL, _).% calls the api via call_api_single() for each Genre in a list of Genres
call_api([]).
call_api([Genre|T]) :-
	call_api_single(Genre),
	call_api(T).

% calls the api via call_api_single() for each Artist in a list of artists
call_artapi([]).
call_artapi([Artist|T]) :-
	call_artapi_single(Artist),
	call_artapi(T).
% verifies if input is number
isNumber([X]) :-
	number(X).

% verfiies if input is genre or artist 
isGenreOrArtist([In]) :-
	possible_tagArray(P),
	member(In,P).

% verfies if input is genre
ifGenre(Input) :-
	Input = 'genre'.

% verfies if input is genre
ifyear(Input) :-
	Input = 'year'.

% verfies if input is genre
ifartist(Input) :-
	Input = 'artist'.

ifempty(Songs) :-
	Songs = [].

% if input is genre then computes genre playlist
genreOrArtist([Input]) :-
	ifGenre(Input) ->
	chooseGenre
;	ifartist(Input) ->
	chooseArtist
;	ifyear(Input) ->
	chooseYear
; write("The input is not year / artist / genre!").

% given input of genre calls api and computes genre playlist
chooseGenre :-
	write("Please select a Genre! Enter random letters for a randomizer! "), flush_output(current_output),
	readln(Input),
	not(isNumber(Input)) ->
	call_api(Input)
;	write('sorry! I only accept words').

% given input of artist calls api and computes artist playlist
chooseArtist :-
	write("Please select an Artist! Enter random letters for a randomizer "), flush_output(current_output),
	readln(Input),
	not(isNumber(Input)) ->
	call_api(Input)
;	write('sorry! I only accept words').

% given input of year calls api and computes year playlist
chooseYear :-
	write("Please select a Year! Enter random letters for a randomizer "), flush_output(current_output),
	readln(Input),
	(isNumber(Input)) ->
	call_api(Input)
;	write('sorry! I only accept words').

%% write(Input),
%% atomics_to_string(Input, InputStr),
% -----USER INTERFACE-----
simpleUI :-
	write("Welcome to our application -> Song Recommender\n"),
	write("You can select a Genre / Artist / Top Song of the specific year!\n"),
    write("Please type genre/ artist/ year (space-separated list) "), flush_output(current_output),
    readln(Input),
	( isNumber(Input) ->
	writeln('sorry! I only accept words')
;	not(isGenreOrArtist(Input)) ->
	writeln('sorry! that is not a valid options') 
;	genreOrArtist(Input)
).

% natural Language interface
% working on it!
naturalUI :-
	write("Please enter your question!\n"),
	readln(Input),
	Result,
	parse(Input, Result).





