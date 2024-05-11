import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioConfig {
  late Dio _client;

  DioConfig() {
    _client = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment("BASE_URL"),
        receiveDataWhenStatusError: true,
      ),
    );

    _client.interceptors.add(ClientInterceptor(client: _client));
  }

  Dio get client => _client;
}

class ClientInterceptor extends Interceptor {
  final Dio client;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  ClientInterceptor({required this.client});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _getToken(options.path);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  Future<String?> _getToken(String path) async {
    final key = _getTokenKey(path);
    return await storage.read(key: key);
  }

  String _getTokenKey(String path) {
    return (path == '/auth/sessions') ? "firebase_token" : "access_token";
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await storage.read(key: "refresh_token");
      if (refreshToken != null) {
        final newToken = await getNewToken();
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';

        try {
          final response = await client.fetch(options);
          handler.resolve(response);
        } catch (e) {
          handler.next(err);
          // GOES TO LOGIN PAGE THEN RETURN
        }
      }
    }

    super.onError(err, handler);
  }

  Future<String?> getNewToken() async {
    final response = await client
        .post('/auth/refresh', data: {'refreshToken': 'YOUR_REFRESH_TOKEN'});
    if (response.statusCode == 200) {
      storage.write(key: "access_token", value: response.data['accessToken']);
      return response.data['accessToken'];
    } else {
      return null;
    }
  }
}
