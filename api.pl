% module that handle api calls

% -----API CALLER HANDLERS-----
% makes the HTTP get request to lastFMs API
% Songs is a list of Song atoms (Song is an atom representing a song name)
% CITATION: adapted from https://github.com/thibaultdewit/Interactive-Tour-Guide
make_api_call_track(URL) :-
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

make_api_call_artist(URL) :-
	write("Connecting to LastFM Server......\n"),
	write(".................................\n\n"),
 	http_open(URL, In_stream, []),
 	json_read_dict(In_stream, Dict),
 	close(In_stream),
 	json_to_songs_artist(Dict, Songs),
	(ifEmpty(Songs) ->
	write("Sorry! There were no artists found!")
;	write_songnames_artist(Songs),
 	write("\n")).

make_api_call_album(URL) :-
	write("Connecting to LastFM Server......\n"),
	write(".................................\n\n"),
 	http_open(URL, In_stream, []),
 	json_read_dict(In_stream, Dict),
 	close(In_stream),
 	json_to_songs_album(Dict, Songs),
	(ifEmpty(Songs) ->
	write("Sorry! There were no albums found!")
;	write_songnames_track(Songs),
 	write("\n")).