% module that handle json file/object

% -----JSON HANDLERS-----
% converts dictionary Dict that json_read_dict() (in make_api_call()) returns
% into the list of songs the JSON contains
json_to_songs_track(Dict, Dict.tracks.track).
json_to_songs_artist(Dict, Dict.topartists.artist).
json_to_songs_album(Dict, Dict.albums.album).

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