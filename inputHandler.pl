% module that handle the input

% -----CONSTANTS OF INPUT HANDLER-----
possible_tagArray([genre, artist, year]).
possible_genreArray([rock,hip,hop,jazz, pop, heavy, metal, country, folk,blues, classical, rhythm, blues, electronic,
					dance, punk, soul, reggae, house, alternative, alt, funk, techno, disco, ambient, lofi, instrumental, gospel,
					singing, trance, grunge, swing, orchestra, world, dubstep, industrial, ska, soundtrack, hardcore, korean, chinese,
					death, progressive, drum, opera, emo, experimental, bluegrass, vocal]).
ui_tag([g,n]).
tag_option([track,artist,album]).


% Tons of helper function that handle input constraints
% verifies if X is a number
isNumber([X]) :-
	number(X).

% verifies if input is genre or artist or year
isGenreOrArtist([In]) :-
	possible_tagArray(P),
	member(In,P).


% verifies if input is g or n (check UI)
isNaturalOrSimple([In]) :-
	ui_tag(P),
	member(In,P).


% verfiies if input is track/ artist / album

isTrackOrArtistOrAlbum([In]) :-
	tag_option(P),
	member(In,P).

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
% handle option in Top Track
genreOrArtistTrack([Input]) :-
	Input = 'genre' ->
	chooseGenreTrack
;	Input = 'artist' ->
	chooseArtistTrack
;	Input = 'year' ->
	chooseYearTrack
; 	write("The input is not a year/artist/genre!\n").

% handle option in Top Artist
genreOrArtistArtist([Input]) :-
	Input = 'genre' ->
	chooseGenreArtist
;	Input = 'year' ->
	chooseYearArtist
; 	write("The input is not a year/artist/genre!\n").

% handle option in Top Album
genreOrArtistAlbums([Input]) :-
	Input = 'genre' ->
	chooseGenreAlbums
;	Input = 'artist' ->
	chooseArtistAlbums
;	Input = 'year' ->
	chooseYearAlbums
; 	write("The input is not a year/artist/genre!\n").

% handle which UI (natural/general UI) are going to execute
simpleOrNatural([Input]) :-
	Input = 'g' ->
	simpleUI
;	Input = 'n' ->
	naturalUI
; 	write("The input is not a year/artist/genre!\n").

% handle which features  are going to execute
trackOrArtistOrAlbum([Input]) :-
	Input = 'track' ->
	topTrackUI
;	Input = 'artist' ->
	topArtistUI
;	Input = 'album' ->
	topAlbumsUI
; 	write("The input is not a track/artist/album!\n").