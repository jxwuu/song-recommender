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

% -----cite-----
% https://www.binarytides.com/linux-fun-commands/ for funny terminal output

% -----Instruction-----
% type mainUI. to start the program
% start the program -> mainUI.

% -----CONSTANTS-----
root_url("http://ws.audioscrobbler.com/2.0").
api_key("5dd0808d6f467e08e647a024417e7318").
api_method_toptrack("tag.gettoptracks").
api_method_topartists("tag.gettopartists").
api_method_albums("tag.gettopalbums").

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







