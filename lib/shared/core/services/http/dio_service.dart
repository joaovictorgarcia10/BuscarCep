import 'package:dio/dio.dart';
import 'http_service.dart';

class DioService implements HttpService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: HttpService.baseUrl,
      headers: {
        "app-version": "4.36.1",
        "build-version-code": "233",
        "content-type": "application/json;charset=UTF-8",
        "service-id": "qualifica",
      },
    ),
  );

  DioService() {
    _dio.interceptors.add(LogInterceptor());
  }

  @override
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    var response = await _dio.get(path, queryParameters: queryParameters);
    return response;
  }

  @override
  Future<dynamic> post(String path,
      {data, Map<String, dynamic>? queryParameters}) async {
    var response =
        await _dio.post(path, data: data, queryParameters: queryParameters);
    return response;
  }

  @override
  Future<dynamic> put(String path,
      {data, Map<String, dynamic>? queryParameters}) async {
    var response =
        await _dio.put(path, data: data, queryParameters: queryParameters);
    return response;
  }
}
