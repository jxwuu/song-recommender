% module for url builder

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