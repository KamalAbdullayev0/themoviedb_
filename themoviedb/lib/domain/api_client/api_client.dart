import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/domain/entity/popular_movie_response.dart';

enum ApiClientExceptionType {
  Network,
  Auth,
  Other,
}

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException({
    required this.type,
  });

  @override
  String toString() {
    return 'ApiClientException{type: $type}';
  }
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = 'f5571daa2fb2319cb40f7d1c15cc0b05';

  static String imageUrl(String path) {
    return '$_imageUrl$path';
  }

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

  Future<T> _get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      validateResponce(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(
        type: ApiClientExceptionType.Network,
      );
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(
        type: ApiClientExceptionType.Other,
      );
    }
  }

  Future<T> _post<T>(
    String path,
    Map<String, dynamic> bodyParatemers,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(path, urlParameters);
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParatemers));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      validateResponce(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(
        type: ApiClientExceptionType.Network,
      );
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(
        type: ApiClientExceptionType.Other,
      );
    }
  }

  Future<String> _makeToken() async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final result = _get(
      '/authentication/token/new',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      '/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      '/search/movie',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
        'query': query,
        'include_adult': true.toString(),
      },
    );
    return result;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final result = _post('/authentication/token/validate_with_login',
        parameters, parser, <String, dynamic>{
      'api_key': _apiKey,
    });
    return result;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    };
    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    final result = _post(
      '/authentication/session/new',
      parameters,
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
      },
    );
    return result;
  }

  void validateResponce(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(
          type: ApiClientExceptionType.Auth,
        );
      } else {
        throw ApiClientException(
          type: ApiClientExceptionType.Other,
        );
      }
    }
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
