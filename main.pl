:- use_module(library(http/http_open)).
:- use_module(library(http/json)).

% example URL:
% http://ws.audioscrobbler.com/2.0/?method=tag.gettoptracks&tag=rock&limit=2&api_key=5dd0808d6f467e08e647a024417e7318&format=json
root_url("http://ws.audioscrobbler.com/2.0").
api_key("5dd0808d6f467e08e647a024417e7318").
api_method("tag.gettoptracks").

%% parse_tag_param(Input, TagParam) :-
%% 	string_concat("tag=", Input, TagParam).

param_method(Method, MethodParam) :-
	string_concat("method=", Method, MethodParam).

param_limit(Num, LimitParam) :-
	string_concat("limit=", Num, LimitParam).

param_key(Key, KeyParam) :-
	string_concat("api_key=", Key, KeyParam).


% adapted from https://github.com/thibaultdewit/Interactive-Tour-Guide
make_api_call(URL, Songs) :-
 	api_key(Key),
 	http_open(URL, In_stream, [request_header('Authorization'=Key)]),
 	json_read_dict(In_stream, Dict),
 	close(In_stream),
 	json_to_songs(Dict, Songs),
 	traverse_dict(Songs, _).

json_to_songs(Dict, Dict.tracks.track).

traverse_dict([], _).
traverse_dict([Track|T], Song) :-
	Song = Track.name,
 	string_concat(Song, " \n", SongNL),
 	write(SongNL),
  	traverse_dict(T, _).

build_url(Tag, URL) :-
	root_url(Root),
	api_key(Key),
	api_method(Method),
	%% parse_tag_param(Input, TagParam),
	param_method(Method, MethodParam),
	param_limit(10, LimitParam),
	param_key(Key, KeyParam),
	string_concat(Root, "?", R1),
	string_concat(R1, MethodParam, R2),
	string_concat(R2, "&", R3),
	string_concat(R3, Tag, R4),
	string_concat(R4, "&", R5),
	string_concat(R5, LimitParam, R6),
	string_concat(R6, "&", R7),
	string_concat(R7, KeyParam, R8),
	string_concat(R8, "&", R9),
	string_concat(R9, "format=json", URL).

call_api(Input) :-
	build_url(Input, URL),
	make_api_call(URL, _).
	%% write(Songs).






q :-
    write("Genre? (space-separated list) "), flush_output(current_output),
    readln(Input),
    atomics_to_string(Input, InputStr),
    call_api(InputStr).
