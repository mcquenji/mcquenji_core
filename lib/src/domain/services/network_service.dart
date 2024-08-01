import 'package:mcquenji_core/mcquenji_core.dart';

/// Base class for all network services.
abstract class NetworkService extends Service {
  @override
  String get name => 'Network';

  /// Sends a GET request to the specified [url] and optional [headers] and [queryParameters].
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  /// Sends a POST request to the specified [url] with the specified [body] and optional [headers] and [queryParameters].
  Future<HttpResponse> post(
    String url,
    Object body, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  /// Sends a PUT request to the specified [url] with the specified [body] and optional [headers] and [queryParameters].
  Future<HttpResponse> put(
    String url,
    Object body, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  /// Sends a DELETE request to the specified [url] and optional [headers] and [queryParameters].
  Future<HttpResponse> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  /// Sends a PATCH request to the specified [url] with the specified [body] and optional [headers] and [queryParameters].
  Future<HttpResponse> patch(
    String url,
    Object body, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
}
