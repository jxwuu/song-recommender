%% This is the main file for our Song Recommender application, which gives the user
%% the option to use either a simplified UI which accepts certain options as input,
%% or a natural language interface UI which can accept queries written in a more
%% natural way, such as "What is the top album of Justin Bieber".

%% The application allows the user to submit a few different types of queries, with which
%% a call to lastFM's API will be made, which will then be returned as JSON and parsed into
%% a human-readable form to serve as the UI output.

%% The primary API methods that lastFM offers that we use are the "tag" methods, which can accept
%% a variety of different types of "things", such as a music genre, an artist's name, or even
%% a year of release. We use "tag.gettoptracks" to return the top music tracks associated with the tag,
%% "tag.gettopartists" to return the top artists associated with the tag, and "tag.gettopalbums"
%% to return the top albums associated with the tag.



%% To run, type "mainUI."

%%%%% Example inputs the naturalUI option can accept:
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


% import module
:- [ui].
:- [urlBuilder].
:- [api].
:- [inputHandler].
:- [jsonHandler].
:- [featuresHandler].
:- use_module(naturalLag).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).

%% CONSTANTS
root_url("http://ws.audioscrobbler.com/2.0").
api_key("5dd0808d6f467e08e647a024417e7318").
api_method_toptrack("tag.gettoptracks").
api_method_topartists("tag.gettopartists").
api_method_albums("tag.gettopalbums").


% CITATION: https://www.binarytides.com/linux-fun-commands/ for funny terminal output

% call the api
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
	write("     \\_/      \\__/  \\__/  \\__/  \\__/      \\_/               \\_/   \\_/    \\_/\n\n"),
	%% atom_string(Item, ItemStr),
	build_url_toptracks(Item, URL),
	make_api_call_track(URL).

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
	write("     \\_/      \\__/  \\__/  \\__/  \\__/      \\_/               \\_/   \\_/    \\_/\n\n"),
	%% atom_string(Item, ItemStr),
	build_url_topartists(Item, URL),
	make_api_call_artist(URL).

% For top album
call_api_single_album(Item) :-
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
	write("     \\_/      \\__/  \\__/  \\__/  \\__/      \\_/               \\_/   \\_/    \\_/\n\n"),
	%% atom_string(Item, ItemStr),
	build_url_topalbums(Item, URL),
	make_api_call_album(URL).