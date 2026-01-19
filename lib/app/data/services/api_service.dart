import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.newsApiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );

    // Add auto-retry interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          if (_shouldRetry(e)) {
            final options = e.requestOptions;
            int retryCount = (options.extra['retryCount'] ?? 0) as int;

            if (retryCount < 3) {
              retryCount++;
              options.extra['retryCount'] = retryCount;

              // Wait before retry (exponential backoff)
              await Future.delayed(Duration(seconds: retryCount * 2));

              try {
                final response = await _dio.fetch(options);
                return handler.resolve(response);
              } catch (err) {
                return handler.next(e);
              }
            }
          }
          return handler.next(e);
        },
      ),
    );

    // Add logging interceptor
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        (e.type == DioExceptionType.unknown && e.message?.contains('SocketException') == true);
  }

  Dio get dio => _dio;

  // GET request wrapper
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Handle Dio errors
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout";
      case DioExceptionType.sendTimeout:
        return "Send timeout";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout";
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) return "Invalid API key";
        if (statusCode == 429) return "Too many requests";
        return "Server error: ${e.response?.statusCode}";
      case DioExceptionType.cancel:
        return "Request cancelled";
      default:
        return "Something went wrong: ${e.message}";
    }
  }
}
