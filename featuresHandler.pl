% module that handles features
% options that you can select within TopTrack/TopArtist/TopAlblum

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