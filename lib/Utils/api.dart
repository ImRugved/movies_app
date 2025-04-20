import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:developer' as developer;
import '../Constants/global.dart';

class API {
  final Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = Global.hostUrl;

    // Add interceptors for detailed logging
    _dio.interceptors.add(
      PrettyDioLogger(),
    );

    // Add custom interceptor for debugging
  }

  Dio get sendRequest => _dio;
}
