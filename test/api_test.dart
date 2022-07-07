import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tankobon/api/models/manga.dart';
import 'package:tankobon/api/models/token.dart';
import 'package:tankobon/api/models/user.dart';

final dioClient = Dio();
Future<void> main() async {
  late String token;

  setUpAll(() async {
    final tokenData = await _getToken();
    print(tokenData.accessToken);
    token = tokenData.accessToken;
  });

  tearDownAll(
    () {
      print('tear down tests');
      dioClient.close();
    },
  );

  test('current user', () async {
    final currentContent = await _getURL(
      url: 'http://localhost:8080/me',
      token: token,
    );

    final jsonContent = currentContent.data as Map<String, dynamic>;
    print(jsonContent);

    final result = User.fromJson(jsonContent);
    print('\nresult: ${result.runtimeType} ${result.toJson()}');

    expect(result, isA<User>());
  });

  test('manga list', () async {
    final currentContent = await _getURL(
      url: 'http://localhost:8080/list',
      token: token,
    );

    final jsonContent = currentContent.data as List<dynamic>;
    print('result length: ${jsonContent.length}');

    final locationList = <Manga>[];

    for (final item in jsonContent) {
      print(jsonContent.indexOf(item));
      print('item index: $item');

      final result = Manga.fromJson(item as Map<String, dynamic>);
      print('\nresult: ${result.runtimeType} ${result.toJson()}');

      locationList.add(result);
    }

    expect(locationList.length, jsonContent.length);
  });
}

Future<Response> _getURL({
  required String url,
  required String token,
  String? contentType,
}) async {
  print('dio GET -> $url');

  final options = Options(
    headers: <String, String>{
      'Authorization': 'Bearer $token',
    },
    sendTimeout: 3000,
    receiveTimeout: 3000,
    contentType: contentType,
  );

  return dioClient
      .get<dynamic>(
    url,
    options: options,
  )
      .onError(
    (error, stackTrace) {
      print('ERROR: $error');
      return null as Response<dynamic>;
    },
  );
}

Future<Response<dynamic>> _postURL({
  required String url,
  String? token,
  Map<String, String>? requestBody,
  Map<String, String>? headers,
  String? contentType,
}) async {
  print('dio POST -> $url');

  final options = Options(
    headers: (headers != null)
        ? headers
        : <String, String>{
            'Authorization': 'Bearer $token',
          },
    sendTimeout: 3000,
    receiveTimeout: 3000,
    contentType: contentType,
  );
  return dioClient
      .post<dynamic>(
    url,
    data: json.encode(requestBody),
    options: options,
  )
      .onError(
    (error, stackTrace) {
      print('ERROR: $error');
      return null as Response<dynamic>;
    },
  );
}

Future<Token> _getToken() async {
  final requestBody = <String, String>{
    'username': 'user',
    'password': 'password',
  };

  return _postURL(
    url: 'http://localhost:8080/login',
    requestBody: requestBody,
    contentType: 'application/json',
  )
      .then(
    (value) => Token.fromJson(
      value.data as Map<String, Object?>,
    ),
  )
      .onError(
    (error, stackTrace) {
      print('ERROR: $error');
      return null as Token;
    },
  );
}
