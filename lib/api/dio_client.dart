import 'dart:convert';

import 'package:dio/dio.dart';

class _DioClient {
  factory _DioClient() => _instance;
  _DioClient._internal();
  final Dio dio = _getDioInstance();
  static final _DioClient _instance = _DioClient._internal();
}

Dio _getDioInstance() {
  final _dio = Dio();

  _dio.options.connectTimeout = Duration.millisecondsPerMinute;
  _dio.options.receiveTimeout = Duration.millisecondsPerMinute;

  _dio.interceptors.add(
    InterceptorsWrapper(),
  );

  return _dio;
}

Future<Response<dynamic>> getURL({
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

  return _DioClient()
      .dio
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

Future<Response<dynamic>?> postURL({
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
  return _DioClient()
      .dio
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
