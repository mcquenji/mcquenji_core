import 'package:mcquenji_core/mcquenji_core.dart';

/// Implementation of [NetworkService] that throws an [OfflineException] for every request.
///
/// Intended to be used when the device is offline.
class OfflineNetworkService extends NetworkService {
  @override
  Future<HttpResponse> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    throw OfflineException(url);
  }

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    throw OfflineException(url);
  }

  @override
  Future<HttpResponse> patch(
    String url,
    Object body, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    throw OfflineException(url);
  }

  @override
  Future<HttpResponse> post(
    String url,
    Object body, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    throw OfflineException(url);
  }

  @override
  Future<HttpResponse> put(
    String url,
    Object body, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    throw OfflineException(url);
  }

  @override
  void dispose() {}
}
