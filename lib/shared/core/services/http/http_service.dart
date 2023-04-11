abstract class HttpService {
  static const String baseUrl = "https://viacep.com.br/ws/";

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});

  Future<dynamic> post(String path,
      {data, Map<String, dynamic>? queryParameters});

  Future<dynamic> put(String path,
      {data, Map<String, dynamic>? queryParameters});
}
