:- use_module(library(http/http_open)).
:- use_module(library(http/json)).



% -----CONSTANTS-----

root_url("http://ws.audioscrobbler.com/2.0").
api_key("5dd0808d6f467e08e647a024417e7318").
api_method("tag.gettoptracks").
possible_tagArray([genre, artist, year]).
possible_genre([pop,hiphop,rock,swing,jazz,blues,classical,poprock,punkrock,emo,screamo,folk,indie,edm,electronic,techno,synth,rap,metal,
				heavymetal,alt,alternative,funk,techno,soul,dance,house,reggae,world,gospel,kpop,grunge,ambient,opera,hardrock,orchestra,ballad,soundtrack,dubstep
				,country, countryrock,industrial,psychedelic]).



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
	string_concat(Artist_name, "\nSong: ", Song_artistD1), 
 	string_concat(Song_artistD1, Song_name, Song_artist_name),
	string_concat(Song_artist_name, "\nLink: ", Song_artist_name2),
	string_concat(Song_artist_name2, Song_url, Song_artist_name3),  
 	string_concat(Song_artist_name3, "\n\n", Song_final),
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
	(ifEmpty(Songs) ->
	write("Sorry! There were no songs found!")
	;write_songnames(Songs),
 	write("\n")).

% builds the URL and makes the API call for this particular Item
call_api_single(Item) :-
	%% atom_string(Item, ItemStr),
	build_url(Item, URL),
	make_api_call(URL, _).

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

% verfies if input is artist
 ifEmpty(Songs) :-
 	Songs = [].

% verifies possible year input
isPossibleYear([Input]) :-
	number(Input),
	Input < 2022,
	Input > 1800.

% if input is genre then computes genre playlist
genreOrArtist([Input]) :-
	Input = 'genre' ->
	chooseGenre
;	Input = 'artist' ->
	chooseArtist
;	Input = 'year' ->
	chooseYear
; 	write("The input is not a year/artist/genre!\n").

% given input of genre calls api and computes genre playlist
chooseGenre :-
	write("Enter a genre(s) (space-separated list):\n"), flush_output(current_output),
	readln(Input),
	not(isNumber(Input)) ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single(InputStr)
;	write("Sorry! I only accept words\n").

% given input of artist calls api and computes artist playlist
chooseArtist :-
	write("Enter an artist(s) (space-separated list):\n"), flush_output(current_output),
	readln(Input),
	not(isNumber(Input)) ->
	atomics_to_string(Input, "+", InputStr),
	call_api_single(InputStr)
;	write("Sorry! I only accept words\n").

% given input of year calls api and computes year playlist
chooseYear :-
	write("Enter a year(s) (space-separated list):\n"), flush_output(current_output),
	readln(Input),
	(isPossibleYear(Input)) ->
	atomics_to_string(Input,InputStr),
	call_api_single(InputStr)
;	write("Sorry! That is not a valid input!\n").



% -----USER INTERFACE-----
simpleUI :-
	write("Welcome to our application -> Song Recommender\n"),
	write("You can select a genre/artist/year, and I'll return the top 5 songs of that category!\n"),
    write('Please enter \"genre\", \"artist\", or \"year\": '), flush_output(current_output),
    readln(Input),
	( isNumber(Input) ->
	writeln("Sorry! I only accept words\n")
;	not(isGenreOrArtist(Input)) ->
	writeln("Sorry! That is not a valid option\n") 
;	genreOrArtist(Input)
).

% natural Language interface
% working on it!
naturalUI :-
	write("Please enter your question!\n"),
	readln(Input),
	Result,
	parse(Input, Result).





