import 'dart:convert';

import 'dart:io';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  // static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = 'f5571daa2fb2319cb40f7d1c15cc0b05';

  Future<String> authenticate({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validatedToken = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validatedToken);
    return sessionId;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters == null) {
      return uri;
    }
    return uri.replace(queryParameters: parameters);
  }

  Future<String> _makeToken() async {
    final url = _makeUri('/authentication/token/new', <String, dynamic>{
      'api_key': _apiKey,
    });
    // final url = Uri.parse(
    //     'https://api.themoviedb.org/3/authentication/token/new?api_key=$_apiKey');
    final request = await _client.getUrl(url);
    final response = await request.close();

    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    // final url = Uri.parse(
    //     'https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$_apiKey');
    final url =
        _makeUri('/authentication/token/validate_with_login', <String, dynamic>{
      'api_key': _apiKey,
    });
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));

    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    // final url = Uri.parse(
    //     'https://api.themoviedb.org/3/authentication/session/new?api_key=$_apiKey');
    final url = _makeUri('/authentication/session/new', <String, dynamic>{
      'api_key': _apiKey,
    });
    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));

    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    final sessionId = json['session_id'] as String;
    return sessionId;
  }
}

extension HttpClientResponseX on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
