import 'package:dio/dio.dart';

class DioClient {
  factory DioClient() => _dioClient;

  DioClient._internal();
  final Dio dio = Dio();

  static final DioClient _dioClient = DioClient._internal();
}
