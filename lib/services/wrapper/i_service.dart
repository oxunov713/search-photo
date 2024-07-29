import 'package:dio/dio.dart';

import '../api_service.dart';

abstract interface class IServiceWrapper {
  abstract final Dio dio;
  abstract final ApiService apiService;

  Future<String> request(
    String path, {
    Method method = Method.get,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, Object>? body,
  });
}

class PhotoServiceWrapper implements IServiceWrapper {
  PhotoServiceWrapper({required this.dio}) : apiService = ApiService(dio);

  @override
  final ApiService apiService;

  @override
  final Dio dio;

  @override
  Future<String> request(
    String path, {
    Method method = Method.get,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, Object>? body,
  }) =>
      apiService.request(
        path,
        method: method,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
      );
}
