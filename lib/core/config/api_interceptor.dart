import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class HttpConfig {
  static const baseUrl = "https://jsonplaceholder.typicode.com";
}

class Api {
  final Dio dio;

  Api({String? baseUrl, Map<String, dynamic>? headers})
    : dio = createDio(baseUrl: baseUrl, headers: headers);

  static Dio createDio({String? baseUrl, Map<String, dynamic>? headers}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? HttpConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: headers ?? {},
      ),
    );

    //
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (e, handler) {
          // Log error
          log("Dio Error: ${e.message}");
          return handler.next(e);
        },
      ),
    );

    return dio;
  }

  //GET
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      String message = _handleDioError(e, path);
      throw Exception(message);
    }
  }

  ///  error handler
  String _handleDioError(DioException e, String path) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return "Request timed out. Please try again.";
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return "Response from $path took too long.";
    } else if (e.type == DioExceptionType.badResponse) {
      final status = e.response?.statusCode ?? 0;
      return " failed: $status ${e.response?.statusMessage}";
    } else if (e.type == DioExceptionType.unknown &&
        e.error is SocketException) {
      return " No internet connection.";
    }
    return "Unexpected error on $path: ${e.message}";
  }
}

//header
class Header {
  static Map<String, String> getHeader() {
    return {'accept': 'application/json', 'Content-Type': 'application/json'};
  }
}
