import 'package:core/app.dart';
import 'package:core/router/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioConfig {
  late Dio _client;

  DioConfig() {
    _client = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment("BASE_URL"),
      ),
    );

    _client.interceptors.add(AuthInterceptor(_client));
  }

  Dio get client => _client;
}

class AuthInterceptor extends InterceptorsWrapper {
  final Dio client;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  AuthInterceptor(this.client);

  // when accessToken is expired & having multiple requests call
  // this variable to lock others request to make sure only trigger call refresh token 01 times
  // to prevent duplicate refresh call
  bool _isRefreshing = false;

  // when having multiple requests call at the same time, you need to store them in a list
  // then loop this list to retry every request later, after call refresh token success
  final _requestsNeedRetry =
      <({RequestOptions options, ErrorInterceptorHandler handler})>[];

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _getToken(options.path);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
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
    final response = err.response;

    if (response != null &&
        // status code for unauthorized usually 401
        response.statusCode == 401 &&
        // refresh token call maybe fail by it self
        // eg: when refreshToken also is expired -> can't get new accessToken
        // usually server also return 401 unauthorized for this case
        // need to exlude it to prevent loop infinite call
        response.requestOptions.path != "/auth/refresh") {
      // if hasn't not refreshing yet, let's start it
      if (!_isRefreshing) {
        _isRefreshing = true;

        // add request (requestOptions and handler) to queue and wait to retry later
        _requestsNeedRetry
            .add((options: response.requestOptions, handler: handler));

        // call api refresh token
        final isRefreshSuccess = await _refreshToken();

        if (isRefreshSuccess) {
          // refresh success, loop requests need retry
          for (var requestNeedRetry in _requestsNeedRetry) {
            // don't need set new accessToken to header here, because these retry
            // will go through onRequest callback above (where new accessToken will be set to header)

            // won't use await because this loop will take longer -> maybe throw: Unhandled Exception: Concurrent modification during iteration
            // because method _requestsNeedRetry.add() is called at the same time
            // final response = await dio.fetch(requestNeedRetry.options);
            // requestNeedRetry.handler.resolve(response);

            client.fetch(requestNeedRetry.options).then((response) {
              requestNeedRetry.handler.resolve(response);
            }).catchError((_) {});
          }

          _requestsNeedRetry.clear();
          _isRefreshing = false;
        } else {
          _requestsNeedRetry.clear();
          // if refresh fail, force logout user here
          final context = navigatorKey.currentState?.context;

          if (context != null && context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginScreen,
              (route) => false,
            );
          }
        }
      } else {
        // if refresh flow is processing, add this request to queue and wait to retry later
        _requestsNeedRetry
            .add((options: response.requestOptions, handler: handler));
      }
    } else {
      // ignore other error is not unauthorized
      return handler.next(err);
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await storage.read(key: "refresh_token");
      final res = await client
          .post('/auth/refresh', data: {'refreshToken': refreshToken});
      if (res.statusCode == 200) {
        // save new access + refresh token to your local storage for using later
        final newToken = res.data['data']['accessToken'];
        await storage.write(key: "access_token", value: newToken);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
